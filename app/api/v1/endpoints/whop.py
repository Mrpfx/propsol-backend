from fastapi import APIRouter, Depends, HTTPException, Request, BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession
from app.db.session import get_session
from app.dependencies.auth import get_current_user
from app.models.user import User
from app.models.propfirm_registration import PropFirmRegistration, PaymentStatus
from app.service.whop_service import WhopService
from app.service.propfirm_registration_service import PropFirmRegistrationService
from pydantic import BaseModel
from uuid import UUID

router = APIRouter()

from pydantic import BaseModel, Field

class CheckoutRequest(BaseModel):
    registration_id: str = Field(alias="registrationId")

    class Config:
        populate_by_name = True
        allow_population_by_field_name = True

@router.post("/checkout-link")
async def create_checkout_link(
    request: CheckoutRequest,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    """
    Generate a Whop checkout link for a Prop Firm Registration.
    """
    reg_service = PropFirmRegistrationService(session)
    registration = None

    # Try to parse as UUID first
    try:
        reg_uuid = UUID(request.registration_id)
        registration = await reg_service.get_registration(reg_uuid)
    except ValueError:
        # If not UUID, try looking up by order_id
        # We need to expose get_by_order_id in service or use repo directly (via service private access or add method)
        # Service wrapper is better. But for quick fix I can access repo via service.repo if public?
        # Service init: self.repo = ...
        # But get_by_order_id is in repo.
        # Let's add get_registration_by_order_id to service wrapper quickly or just use repo here?
        # Ideally add to service. I'll add a helper method to service class in separate tool call if needed.
        # Check service file again... it doesn't have it.
        # I will just access repo for now if Python allows (it does).
        registration = await reg_service.repo.get_by_order_id(request.registration_id)

    if not registration:
        raise HTTPException(status_code=404, detail="Registration not found")
    if registration.user_id != current_user.id:
        raise HTTPException(status_code=403, detail="Not authorized")

    if registration.payment_status == PaymentStatus.completed:
        raise HTTPException(status_code=400, detail="Registration already paid")

    # Calculate discount for new users (first purchase)
    # Check if user has any completed payments
    # We can use the service to get registrations, but we need to filter by payment status manually if service doesn't support it
    # Or just check if they have any registrations with payment_status=completed
    user_registrations = await reg_service.get_registrations_by_user(current_user.id)
    has_prior_purchase = any(r.payment_status == PaymentStatus.completed for r in user_registrations)

    final_amount = registration.propfirm_account_cost
    if not has_prior_purchase:
        # Apply 5% discount
        discount_amount = final_amount * 0.05
        final_amount = final_amount - discount_amount
        # Ensure 2 decimal places
        final_amount = round(final_amount, 2)

    whop_service = WhopService()
    try:
        checkout_url = await whop_service.create_payment_link(
            amount=final_amount,
            currency="usd", # Default to USD or fetch from config/registration
            title=f"Payment for {registration.propfirm_name}",
            registration_id=registration.id
        )
        return {"checkout_url": checkout_url}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))

@router.post("/webhook")
async def whop_webhook(
    request: Request,
    background_tasks: BackgroundTasks,
    session: AsyncSession = Depends(get_session)
):
    """
    Handle webhooks from Whop.
    """
    """
    Handle webhooks from Whop.
    """
    # Get raw body for signature verification
    raw_body = await request.body()
    headers = request.headers

    whop_service = WhopService()

    # Verify signature using raw body
    if not whop_service.verify_signature(raw_body, headers):
        # We check settings inside verify_signature, so if secret is missing it returns True (with warning).
        # If it returns False, it means validation failed.
        # However, verify_signature method name in service was 'validate_webhook' before?
        # I added 'verify_signature' method in previous step.
        # But I should clean up 'validate_webhook' which was the placeholder.
        # Let's check service again to be sure I didn't leave a mess.
        # The previous edit replaced validate_webhook with a new implementation AND added verify_signature inside it?
        # No, I see indentation suggesting I added verify_signature as a separate method or replaced it?
        # I need to be careful. I will use `verify_signature` if I added it, or `validate_webhook` if I updated it.
        # Looking at previous step diff: I replaced `validate_webhook` with a version that returned False, AND added `verify_signature`.
        # So I should use `verify_signature`.
        raise HTTPException(status_code=400, detail="Invalid webhook signature")

    import json
    try:
        payload = json.loads(raw_body)
    except json.JSONDecodeError:
        raise HTTPException(status_code=400, detail="Invalid JSON")

    event_type = payload.get("action") or payload.get("type")
    # Whop webhook structure varies, need to be careful.
    # Common convention: payload might have 'action': 'payment.succeeded' or similar.
    # The prompt says: "Whop sends the setup_intent.succeeded webhook" or "payment.succeeded" / "payment.failed"

    if event_type == "payment.succeeded":
        # Extract metadata to find registration
        # The structure of the payload depends on the event.
        # Usually data is inside 'data' or 'payment' object.
        data = payload.get("data", {})
        metadata = data.get("metadata", {})

        # We might need to look deeper if it's nested differently
        if not metadata:
            # Fallback for plan-based checkouts.
            # If we created a plan with description containing ID, or if we can pass metadata to plan creation.
            # In my service implementation, I passed description=f"Registration ID: {id}".
            # We can try to parse description if metadata is empty.
            pass

        registration_id_str = metadata.get("registration_id")

        # If we can't find it in metadata, try description
        if not registration_id_str:
            description = data.get("description", "")
            if "Registration ID: " in description:
                try:
                    registration_id_str = description.split("Registration ID: ")[1].strip()
                except IndexError:
                    pass

        if registration_id_str:
            try:
                reg_id = UUID(registration_id_str)
                reg_service = PropFirmRegistrationService(session)

                # Fetch registration to check status (Idempotency)
                existing_reg = await reg_service.get_registration(reg_id)
                if not existing_reg:
                     print(f"PropFirm Registration not found for ID: {reg_id}")
                     return {"status": "skipped", "reason": "not_found"}

                from app.models.propfirm_registration import AccountStatus, PaymentStatus

                if existing_reg.account_status != AccountStatus.pending or existing_reg.payment_status == PaymentStatus.completed:
                     print(f"Skipping Whop webhook for {reg_id} - already processed.")
                     return {"status": "skipped", "reason": "already_processed"}

                # Update registration payment status
                # We need to use update_registration but it requires schema.
                # Or we can just update the model directly since we are in backend.
                # PropFirmRegistrationService.update_registration handles notifications, so best to use that.

                from app.schema.propfirm_registration import PropFirmRegistrationUpdate

                from app.models.propfirm_registration import AccountStatus

                update_data = PropFirmRegistrationUpdate(
                    payment_status=PaymentStatus.completed,
                    account_status=AccountStatus.pending
                )

                # We need to await the update.
                # Warning: background_tasks in webhook context might be tricky if we want immediate consistency,
                # but 'update_registration' signature requires background_tasks for email sending.

                updated_reg = await reg_service.update_registration(reg_id, update_data, background_tasks)

                # Process referral earnings
                if updated_reg and updated_reg.user_id:
                    user = await session.get(User, updated_reg.user_id)
                    if user and user.referred_by:
                        from app.service.wallet_service import process_referral_purchase
                        # We need to determine pass type from registration
                        # updated_reg is the model instance, so we can access fields directly.

                        # Ensure we have the latest data
                        await session.refresh(updated_reg)

                        await process_referral_purchase(
                            db=session,
                            referred_user_id=user.id,
                            referrer_code=user.referred_by,
                            pass_type=updated_reg.pass_type,
                            purchase_amount=updated_reg.propfirm_account_cost,
                            registration_id=updated_reg.id
                        )

            except ValueError:
                print(f"Invalid UUID in webhook: {registration_id_str}")

    return {"status": "success"}
