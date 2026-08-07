from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from pydantic import BaseModel
from sqlmodel.ext.asyncio.session import AsyncSession
from uuid import UUID

from app.db.session import get_session
from sqlmodel import select
from app.dependencies.auth import get_current_admin
from app.models.admin import Admin
from app.models.user import User
from app.service.nowpayments_service import NOWPaymentsService
from app.service.whop_service import WhopService
from app.service.propfirm_registration_service import PropFirmRegistrationService
from app.models.propfirm_registration import PropFirmRegistration, PaymentStatus, AccountStatus

router = APIRouter()

class PaymentDiagnosisRequest(BaseModel):
    provider: str  # "nowpayments" or "whop"
    identifier: str # payment_id (crypto) or registration_id (whop) or email
    force_sync: bool = False

class PaymentDiagnosisResponse(BaseModel):
    provider: str
    identifier: str
    local_status: str | None
    remote_status: str | None
    mismatch: bool
    action_taken: str

@router.post("/diagnose", response_model=PaymentDiagnosisResponse)
async def diagnose_payment(
    request: PaymentDiagnosisRequest,
    background_tasks: BackgroundTasks,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    """
    Diagnose and optionally force-sync a payment.
    """
    response_data = {
        "provider": request.provider,
        "identifier": request.identifier,
        "local_status": "unknown",
        "remote_status": "unknown",
        "mismatch": False,
        "action_taken": "None"
    }

    reg_service = PropFirmRegistrationService(session)

    if request.provider == "nowpayments":
        service = NOWPaymentsService(session)
        # Check local DB
        # Identifier is likely payment_id (int or str) or order_id
        # Let's assume payment_id first
        crypto_payment = await service.repo.get_by_payment_id(request.identifier)
        if not crypto_payment:
             # Try assuming it's an order_id
             crypto_payment = await service.repo.get_by_order_id(request.identifier)

        if crypto_payment:
            response_data["local_status"] = crypto_payment.payment_status

            # Check remote
            pid = str(crypto_payment.payment_id) if crypto_payment.payment_id else None
            remote_status = None

            if pid:
                try:
                    api_status = await service.get_payment_status(pid)
                    remote_status = api_status.get("payment_status")
                except Exception as e:
                    remote_status = f"Error: {str(e)}"
            else:
                remote_status = "No Payment ID in DB"

            response_data["remote_status"] = remote_status

            if remote_status and remote_status != crypto_payment.payment_status:
                response_data["mismatch"] = True

            if request.force_sync or response_data["mismatch"]:
                if remote_status:
                    # Update DB
                    from app.schema.crypto_payment import CryptoPaymentUpdate
                    await service.repo.update(db_obj=crypto_payment, obj_in=CryptoPaymentUpdate(payment_status=remote_status))

                    # Trigger side effects
                    if remote_status in ["confirmed", "finished"]:
                        from app.api.v1.endpoints.crypto_payments import process_payment_update
                        background_tasks.add_task(
                            process_payment_update,
                            payment_id=crypto_payment.id,
                            payment_status=remote_status,
                            user_id=crypto_payment.user_id
                        )
                        response_data["action_taken"] = f"Synced to {remote_status} & Triggered Side Effects"
                    else:
                        response_data["action_taken"] = f"Synced to {remote_status}"

    elif request.provider == "whop":
        service = WhopService()
        # Identifier is registration_id (UUID) or email
        registration = None
        reg_id = None

        if "@" in request.identifier:
            # Lookup by email
            statement = select(User).where(User.email == request.identifier)
            result = await session.execute(statement)
            user = result.scalars().first()

            if user:
                 # Get latest registration
                 statement = select(PropFirmRegistration).where(PropFirmRegistration.user_id == user.id).order_by(PropFirmRegistration.created_at.desc())
                 result = await session.execute(statement)
                 registration = result.scalars().first()

                 if not registration:
                      response_data["local_status"] = "User found but no registrations"
                 else:
                    reg_id = registration.id
            else:
                 response_data["local_status"] = "User not found"
        else:
            # Try UUID first
            try:
                reg_id = UUID(request.identifier)
                registration = await reg_service.get_registration(reg_id)
            except ValueError:
                # Not a UUID, try order_id
                registration = await reg_service.repo.get_by_order_id(request.identifier)
                if not registration:
                     response_data["local_status"] = "Invalid UUID or Order ID not found"
                else:
                     reg_id = registration.id


        if registration and reg_id:
            response_data["local_status"] = f"{registration.payment_status} / {registration.account_status}"

            # Check remote
            whop_payment = await service.find_payment_by_registration_id(str(reg_id))

            if not whop_payment and registration.user_id:
                # Fallback: Try by Email
                user = await session.get(User, registration.user_id)
                if user:
                    whop_payment = await service.find_payment_by_email(user.email)
                    if whop_payment:
                         response_data["action_taken"] = "Found via Email Fallback"

            if whop_payment:
                whop_status = whop_payment.get("status") # "paid"
                response_data["remote_status"] = whop_status

                is_paid = whop_status == "paid"
                local_is_paid = registration.payment_status == PaymentStatus.completed

                if is_paid != local_is_paid:
                    response_data["mismatch"] = True

                if (request.force_sync or response_data["mismatch"]) and is_paid:
                    # Force update
                    registration.payment_status = PaymentStatus.completed
                    registration.account_status = AccountStatus.pending
                    await session.commit()
                    await session.refresh(registration)

                    # Trigger side effects
                    from app.schema.propfirm_registration import PropFirmRegistrationUpdate
                    await reg_service.update_registration(
                        registration.id,
                        PropFirmRegistrationUpdate(
                            payment_status=PaymentStatus.completed,
                            account_status=AccountStatus.pending
                        ),
                        background_tasks
                    )
                     # Also trigger referral if needed
                    if registration.user_id:
                        user = await session.get(User, registration.user_id)
                        if user and user.referred_by:
                            from app.service.wallet_service import process_referral_purchase
                            await process_referral_purchase(
                                db=session,
                                referred_user_id=user.id,
                                referrer_code=user.referred_by,
                                pass_type=registration.pass_type,
                                purchase_amount=registration.propfirm_account_cost,
                                registration_id=registration.id
                            )

                    response_data["action_taken"] = "Synced to Completed & Triggered Side Effects"
            else:
                response_data["remote_status"] = "Not Found in Whop"

    return response_data
