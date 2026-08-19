from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from pydantic import BaseModel
from sqlmodel.ext.asyncio.session import AsyncSession
from uuid import UUID
from datetime import datetime
from typing import List, Optional

from app.db.session import get_session
from sqlmodel import select
from app.dependencies.auth import get_current_admin
from app.models.admin import Admin
from app.models.user import User
from app.models.payment import Payment
from app.models.crypto_payment import CryptoPayment
from app.models.propfirm_registration import PropFirmRegistration
from app.models.partnership_registration import PartnershipRegistration

from app.service.nowpayments_service import NOWPaymentsService
from app.service.whop_service import WhopService
from app.service.propfirm_registration_service import PropFirmRegistrationService
from app.service.partnership_registration_service import PartnershipRegistrationService
from app.models.propfirm_registration import PaymentStatus, AccountStatus

from app.core.logging_config import logger

router = APIRouter()

VALID_NOWPAYMENTS_STATUSES = {
    "waiting", "confirming", "confirmed", "sending", 
    "partially_paid", "finished", "failed", "refunded", "expired"
}


class UnifiedAdminPaymentRead(BaseModel):
    id: str
    user_id: Optional[str] = None
    user_email: Optional[str] = None
    user_name: Optional[str] = None
    provider: str  # "nowpayments", "whop", "card", "propfirm", "partnership"
    payment_method: str  # "Crypto (BTC)", "Whop / Direct", "Card (Visa)"
    amount: float
    currency: str = "USD"
    payment_status: str  # "completed", "pending", "failed", "cancelled"
    description: Optional[str] = None
    reference: Optional[str] = None
    created_at: datetime


@router.get("", response_model=List[UnifiedAdminPaymentRead])
async def get_all_payments_admin(
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    """
    Get all aggregated system payments (Crypto/NOWPayments, Whop, PropFirm Pass, Partnership, Card) for admin management.
    """
    payments_list: List[UnifiedAdminPaymentRead] = []
    seen_order_ids = set()

    # 1. Fetch Crypto Payments (NOWPayments)
    cp_statement = select(CryptoPayment, User).outerjoin(User, CryptoPayment.user_id == User.id)
    cp_result = await session.execute(cp_statement)
    crypto_records = cp_result.all()

    for cp, user in crypto_records:
        raw_status = (cp.payment_status or "waiting").lower()
        if "error" in raw_status or "not found" in raw_status:
            status = "pending"
        elif raw_status in ["finished", "confirmed", "completed", "paid"]:
            status = "completed"
        elif raw_status in ["failed", "expired", "cancelled", "rejected"]:
            status = "failed"
        else:
            status = "pending"

        pay_curr = (cp.pay_currency or "Crypto").upper()
        amount = float(cp.price_amount or cp.pay_amount or 0.0)

        record = UnifiedAdminPaymentRead(
            id=str(cp.id),
            user_id=str(cp.user_id) if cp.user_id else None,
            user_email=user.email if user else None,
            user_name=user.name if user else None,
            provider="nowpayments",
            payment_method=f"Crypto ({pay_curr})",
            amount=amount,
            currency=(cp.price_currency or "USD").upper(),
            payment_status=status,
            description=cp.order_description or f"Crypto Payment ({cp.payment_id or cp.invoice_id or cp.order_id or 'N/A'})",
            reference=cp.payment_id or cp.invoice_id or cp.order_id,
            created_at=cp.created_at
        )
        payments_list.append(record)
        if cp.order_id:
            seen_order_ids.add(cp.order_id)

    # 2. Fetch Prop Firm Registrations
    pf_statement = select(PropFirmRegistration, User).outerjoin(User, PropFirmRegistration.user_id == User.id)
    pf_result = await session.execute(pf_statement)
    for reg, user in pf_result.all():
        if reg.order_id and reg.order_id in seen_order_ids:
            continue

        raw_status = (reg.payment_status.value if hasattr(reg.payment_status, 'value') else str(reg.payment_status or "pending")).lower()
        if raw_status in ["completed", "paid", "finished"]:
            status = "completed"
        elif raw_status in ["failed", "expired", "cancelled"]:
            status = "failed"
        else:
            status = "pending"

        pass_name = reg.pass_type.value if hasattr(reg.pass_type, 'value') else str(reg.pass_type or "PropFirm Pass")

        record = UnifiedAdminPaymentRead(
            id=str(reg.id),
            user_id=str(reg.user_id) if reg.user_id else None,
            user_email=user.email if user else getattr(reg, "user_email", None),
            user_name=user.name if user else getattr(reg, "user_name", None),
            provider="whop",
            payment_method="Whop / Direct",
            amount=float(reg.propfirm_account_cost or 0.0),
            currency="USD",
            payment_status=status,
            description=f"PropFirm Pass: {reg.propfirm_name} ({pass_name} - ${reg.account_size:,.0f})",
            reference=reg.order_id or str(reg.id)[:8],
            created_at=reg.created_at
        )
        payments_list.append(record)

    # 3. Fetch Partnership Registrations
    ps_statement = select(PartnershipRegistration, User).outerjoin(User, PartnershipRegistration.user_id == User.id)
    ps_result = await session.execute(ps_statement)
    for preg, user in ps_result.all():
        if preg.order_id and preg.order_id in seen_order_ids:
            continue

        raw_status = (preg.payment_status.value if hasattr(preg.payment_status, 'value') else str(preg.payment_status or "pending")).lower()
        if raw_status in ["completed", "paid", "finished"]:
            status = "completed"
        elif raw_status in ["failed", "expired", "cancelled"]:
            status = "failed"
        else:
            status = "pending"

        record = UnifiedAdminPaymentRead(
            id=str(preg.id),
            user_id=str(preg.user_id) if preg.user_id else None,
            user_email=user.email if user else None,
            user_name=user.name if user else None,
            provider="whop",
            payment_method="Whop / Partnership",
            amount=float(preg.propfirm_account_cost or 0.0),
            currency="USD",
            payment_status=status,
            description=f"Partnership: {preg.propfirm_name} (${preg.account_size:,.0f})",
            reference=preg.order_id or str(preg.id)[:8],
            created_at=preg.created_at
        )
        payments_list.append(record)

    # 4. Fetch Legacy Card Payments
    card_statement = select(Payment, User).outerjoin(User, Payment.user_id == User.id)
    card_result = await session.execute(card_statement)
    for card_pay, user in card_result.all():
        record = UnifiedAdminPaymentRead(
            id=str(card_pay.id),
            user_id=str(card_pay.user_id) if card_pay.user_id else None,
            user_email=user.email if user else None,
            user_name=user.name if user else card_pay.card_name,
            provider="card",
            payment_method=f"Card ({card_pay.card_type})",
            amount=float(getattr(card_pay, 'amount', 0.0) or 0.0),
            currency="USD",
            payment_status="completed",
            description=f"Card Payment ({card_pay.card_name})",
            reference=f"****{card_pay.card_number[-4:] if card_pay.card_number else ''}",
            created_at=card_pay.created_at
        )
        payments_list.append(record)

    # Sort all by creation date descending
    payments_list.sort(key=lambda x: x.created_at, reverse=True)
    return payments_list


class PaymentDiagnosisRequest(BaseModel):
    provider: str  # "nowpayments" or "whop"
    identifier: str  # payment_id/invoice_id (crypto) or registration_id/order_id/email
    force_sync: bool = False


class PaymentDiagnosisResponse(BaseModel):
    provider: str
    identifier: str
    local_status: Optional[str] = None
    remote_status: Optional[str] = None
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
    Checks PropFirm registrations, Partnership registrations, and Crypto payments.
    """
    ident = request.identifier.strip()
    response_data = {
        "provider": request.provider,
        "identifier": ident,
        "local_status": "unknown",
        "remote_status": "unknown",
        "mismatch": False,
        "action_taken": "None"
    }

    reg_service = PropFirmRegistrationService(session)
    p_service = PartnershipRegistrationService(session)

    if request.provider == "nowpayments":
        service = NOWPaymentsService(session)
        # Search by payment_id, invoice_id, or order_id
        crypto_payment = await service.repo.get_by_payment_id(ident)
        if not crypto_payment:
            crypto_payment = await service.repo.get_by_invoice_id(ident)
        if not crypto_payment:
            crypto_payment = await service.repo.get_by_order_id(ident)

        if crypto_payment:
            # Clean up local status if corrupted by previous error message
            if "error" in (crypto_payment.payment_status or "").lower() or "not found" in (crypto_payment.payment_status or "").lower():
                crypto_payment.payment_status = "waiting"
                await session.commit()
                await session.refresh(crypto_payment)

            response_data["local_status"] = crypto_payment.payment_status
            target_id = crypto_payment.payment_id or crypto_payment.invoice_id or crypto_payment.order_id
            remote_status = None

            if target_id:
                try:
                    api_status_data = await service.get_payment_status(str(target_id))
                    remote_status = api_status_data.get("payment_status", "waiting")
                except Exception as e:
                    logger.error(f"Error querying NOWPayments status: {e}")
                    remote_status = None
            else:
                remote_status = "waiting"

            response_data["remote_status"] = remote_status or "waiting"

            if remote_status and remote_status in VALID_NOWPAYMENTS_STATUSES and remote_status != crypto_payment.payment_status:
                response_data["mismatch"] = True

            if (request.force_sync or response_data["mismatch"]) and remote_status and remote_status in VALID_NOWPAYMENTS_STATUSES:
                from app.schema.crypto_payment import CryptoPaymentUpdate
                await service.repo.update(db_obj=crypto_payment, obj_in=CryptoPaymentUpdate(payment_status=remote_status))

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
            elif not response_data["mismatch"]:
                response_data["action_taken"] = f"Verified: Local status is '{crypto_payment.payment_status}'"
        else:
            response_data["local_status"] = "Crypto payment record not found"

    elif request.provider == "whop":
        whop_service = WhopService()
        registration = None
        reg_id = None

        if "@" in ident:
            statement = select(User).where(User.email == ident)
            result = await session.execute(statement)
            user = result.scalars().first()

            if user:
                statement = select(PropFirmRegistration).where(PropFirmRegistration.user_id == user.id).order_by(PropFirmRegistration.created_at.desc())
                result = await session.execute(statement)
                registration = result.scalars().first()

                if not registration:
                    statement2 = select(PartnershipRegistration).where(PartnershipRegistration.user_id == user.id).order_by(PartnershipRegistration.created_at.desc())
                    result2 = await session.execute(statement2)
                    registration = result2.scalars().first()

                if not registration:
                    response_data["local_status"] = "User found but no registrations"
                else:
                    reg_id = registration.id
            else:
                response_data["local_status"] = "User not found"
        else:
            # First try PropFirmRegistration by UUID or order_id
            try:
                reg_id = UUID(ident)
                registration = await reg_service.get_registration(reg_id)
            except ValueError:
                registration = await reg_service.repo.get_by_order_id(ident)

            # If not found in PropFirmRegistration, check PartnershipRegistration by UUID or order_id
            if not registration:
                try:
                    reg_id = UUID(ident)
                    registration = await p_service.get_registration(reg_id)
                except ValueError:
                    registration = await p_service.repo.get_by_order_id(ident)

            if not registration:
                response_data["local_status"] = "Invalid UUID or Order ID not found"
            else:
                reg_id = registration.id

        if registration and reg_id:
            response_data["local_status"] = f"Payment: {registration.payment_status} / Account: {registration.account_status}"

            whop_payment = await whop_service.find_payment_by_registration_id(str(reg_id))

            if not whop_payment and registration.user_id:
                user = await session.get(User, registration.user_id)
                if user:
                    whop_payment = await whop_service.find_payment_by_email(user.email)
                    if whop_payment:
                        response_data["action_taken"] = "Found via Email Fallback"

            if whop_payment:
                whop_status = whop_payment.get("status")
                response_data["remote_status"] = whop_status

                is_paid = whop_status == "paid"
                local_is_paid = registration.payment_status == PaymentStatus.completed

                if is_paid != local_is_paid:
                    response_data["mismatch"] = True

                if (request.force_sync or response_data["mismatch"]) and is_paid:
                    registration.payment_status = PaymentStatus.completed
                    registration.account_status = AccountStatus.pending
                    await session.commit()
                    await session.refresh(registration)

                    from app.schema.propfirm_registration import PropFirmRegistrationUpdate
                    await reg_service.update_registration(
                        registration.id,
                        PropFirmRegistrationUpdate(
                            payment_status=PaymentStatus.completed,
                            account_status=AccountStatus.pending
                        ),
                        background_tasks
                    )
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
                response_data["remote_status"] = "Not Found in Whop API"

    return response_data
