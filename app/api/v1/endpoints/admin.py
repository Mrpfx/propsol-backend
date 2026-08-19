from typing import Any, List

from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_admin, require_role
from app.models.admin import Admin
from app.models.user_purchased_package import UserPurchasedPackage
from app.schema.admin import AdminCreate, AdminRead, AdminUpdate, AdminEmailRequest, AdminPasswordReset
from app.schema.user import UserRead, UserUpdate
from app.schema.transactions import TransactionRead
from app.schema.user_purchased_package import UserPurchasedPackageCreate, UserPurchasedPackageRead
from app.schema.wallet import WithdrawalStatusUpdate, AdminWithdrawalListResponse

from app.service.admin_service import AdminService
from app.schema.propfirm_registration import PropFirmRegistrationRead, PropFirmRegistrationUpdate, PropFirmRegistrationAdminRead
from app.service.propfirm_registration_service import PropFirmRegistrationService
from uuid import UUID
from app.service.mail import send_email
from app.models.user import User

router = APIRouter()


from app.config import settings

@router.post("", response_model=AdminRead)
async def create_admin(
    admin_in: AdminCreate,
    current_admin: Admin = Depends(require_role("super_admin")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Create new admin.
    Requires valid 10-character admin security code from .env / settings.
    """
    expected_code = (settings.ADMIN_SECURITY_CODE or "").strip()
    provided_code = (admin_in.security_code or "").strip()

    if not provided_code or provided_code != expected_code:
        raise HTTPException(
            status_code=400,
            detail="Invalid security code. You must provide the valid 10-character security code stored in system settings to add an admin.",
        )

    service = AdminService(session)
    admin = await service.get_admin_by_email(admin_in.email)
    if admin:
        raise HTTPException(
            status_code=400,
            detail="The admin with this email already exists in the system.",
        )
    admin = await service.create_admin(admin_in)
    return admin




@router.get("/me", response_model=AdminRead)
async def read_admin_me(
    current_admin: Admin = Depends(get_current_admin),
) -> Any:
    """
    Get current admin.
    """
    return current_admin


@router.put("/me", response_model=AdminRead)
async def update_admin_me(
    admin_in: AdminUpdate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Update current admin's profile (name, password).
    """
    service = AdminService(session)
    admin = await service.update_admin(current_admin.id, admin_in)
    return admin


@router.put("/{admin_id}", response_model=AdminRead)
async def update_admin(
    admin_id: UUID,
    admin_in: AdminUpdate,
    current_admin: Admin = Depends(require_role("super_admin")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Update an admin (Super Admin only).
    """
    service = AdminService(session)
    admin = await service.update_admin(admin_id, admin_in)
    if not admin:
        raise HTTPException(
            status_code=404,
            detail="Admin not found",
        )
    return admin


@router.delete("/{admin_id}", response_model=AdminRead)
async def delete_admin(
    admin_id: UUID,
    current_admin: Admin = Depends(require_role("super_admin")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Delete an admin (Super Admin only).
    """
    service = AdminService(session)
    admin = await service.delete_admin(admin_id)
    if not admin:
        raise HTTPException(
            status_code=404,
            detail="Admin not found",
        )
    return admin




@router.get("", response_model=List[AdminRead])
async def list_admins(
    skip: int = 0,
    limit: int = 100,
    current_admin: Admin = Depends(require_role("super_admin")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Retrieve all admins (Super Admin only).
    """
    service = AdminService(session)
    return await service.get_all_admins(skip=skip, limit=limit)






@router.get("/stats", response_model=dict)
async def read_stats(
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    service = AdminService(session)
    return await service.get_stats()

@router.get("/users", response_model=List[UserRead])
async def read_users(
    current_admin: Admin = Depends(require_role("users")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    service = AdminService(session)
    users = await service.get_all_users()
    return users


@router.get("/transactions", response_model=List[TransactionRead])
async def read_transactions(
    current_admin: Admin = Depends(require_role("transactions")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    service = AdminService(session)
    return await service.get_all_transactions()


@router.get("/prop-firms", response_model=List[PropFirmRegistrationAdminRead])
async def read_prop_firms(
    current_admin: Admin = Depends(require_role("prop_firms")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    service = AdminService(session)
    return await service.get_all_prop_firm_registrations()


@router.put("/users/{user_id}", response_model=UserRead)
async def update_user(
    user_id: UUID,
    user_in: UserUpdate,
    current_admin: Admin = Depends(require_role("users")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    service = AdminService(session)
    user = await service.update_user(user_id, user_in)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


@router.put("/prop-firm/{registration_id}", response_model=PropFirmRegistrationRead)
async def update_propfirm_registration(
    registration_id: UUID,
    registration_in: PropFirmRegistrationUpdate,
    background_tasks: BackgroundTasks,
    current_admin: Admin = Depends(require_role("prop_firms")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    service = PropFirmRegistrationService(session)
    registration = await service.update_registration(registration_id, registration_in, background_tasks)
    if not registration:
        raise HTTPException(status_code=404, detail="Registration not found")
    return registration

@router.post("/packages", response_model=UserPurchasedPackageRead)
async def assign_package_to_user(
    package_in: UserPurchasedPackageCreate,
    background_tasks: BackgroundTasks,
    current_admin: Admin = Depends(require_role("users")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    package = UserPurchasedPackage.from_orm(package_in)
    session.add(package)
    await session.commit()
    await session.refresh(package)

    user = await session.get(User, package.user_id)
    if user:
        background_tasks.add_task(
            send_email,
            email_to=user.email,
            subject="Package Purchased Successfully",
            template_name="user_package_purchased.html",
            context={
                "name": user.name,
                "package_name": package.package_name,
                "price": package.price,
                "date": package.created_at.strftime("%Y-%m-%d")
            }
        )

    return package


@router.get("/withdrawals", response_model=AdminWithdrawalListResponse)
async def list_all_withdrawals(
    status: str = None,
    limit: int = 10,
    page: int = 0,
    current_admin: Admin = Depends(require_role("payouts")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    List all withdrawals with optional status filter.
    """
    from app.service.wallet_service import WalletService
    service = WalletService(session)
    return await service.get_all_withdrawals(status=status, limit=limit, offset=page * limit)


@router.patch("/withdrawals/{withdrawal_id}", response_model=Any)
async def update_withdrawal_status(
    withdrawal_id: UUID,
    status_update: WithdrawalStatusUpdate,
    background_tasks: BackgroundTasks,
    current_admin: Admin = Depends(require_role("payouts")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Update withdrawal status (admin only).
    """
    from app.service.wallet_service import WalletService

    service = WalletService(session)

    withdrawal = await service.update_withdrawal_status(
        withdrawal_id=withdrawal_id,
        status=status_update.status,
        admin_notes=status_update.admin_notes,
        rejection_reason=status_update.rejection_reason,
        background_tasks=background_tasks
    )

    if not withdrawal:
        raise HTTPException(
            status_code=404,
            detail="Withdrawal not found"
        )

    return withdrawal


@router.post("/withdrawals/{withdrawal_id}/approve", response_model=dict)
async def approve_withdrawal_payout(
    withdrawal_id: UUID,
    current_admin: Admin = Depends(require_role("payouts")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Approve a withdrawal and initiate NOWPayments payout.
    """
    from app.service.wallet_service import WalletService
    service = WalletService(session)
    try:
        withdrawal = await service.initiate_nowpayments_payout(withdrawal_id)
        return {
            "message": "Payout initiated successfully",
            "batch_withdrawal_id": withdrawal.batch_withdrawal_id,
            "payout_id": withdrawal.payout_id,
            "status": withdrawal.external_status
        }
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))


@router.post("/withdrawals/verify", response_model=dict)
async def verify_withdrawal_payout(
    batch_id: str,
    verification_code: str,
    current_admin: Admin = Depends(require_role("payouts")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Verify a NOWPayments payout batch with 2FA code.
    """
    from app.service.wallet_service import WalletService
    service = WalletService(session)
    is_verified = await service.verify_nowpayments_payout(batch_id, verification_code)

    if is_verified:
        return {"message": "Payout verified successfully"}
    else:
        raise HTTPException(status_code=400, detail="Verification failed")


@router.get("/withdrawals/nowpayments", response_model=dict)
async def list_nowpayments_payouts(
    limit: int = 10,
    page: int = 0,
    current_admin: Admin = Depends(require_role("payouts")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    List payouts directly from NOWPayments.
    """
    from app.service.nowpayments_service import NOWPaymentsService
    now_service = NOWPaymentsService()
    return await now_service.get_payouts({"limit": limit, "page": page})


@router.post("/send-email", response_model=dict)
async def send_email_to_users(
    email_request: AdminEmailRequest,
    background_tasks: BackgroundTasks,
    current_admin: Admin = Depends(require_role("email_marketing")),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Send email to users (Admin with email_marketing role).
    """
    service = AdminService(session)

    users_to_send = []
    if email_request.send_to_all:
        users_to_send = await service.get_all_users()
    elif email_request.user_ids:
        for uid in email_request.user_ids:
            user = await session.get(User, uid)
            if user:
                users_to_send.append(user)

    if not users_to_send:
         raise HTTPException(status_code=400, detail="No users selected")

    sent_count = 0
    for user in users_to_send:
        context = {
            "name": user.name,
            "user_name": user.name,
            "email": user.email,
        }

        template_name = "admin_custom_message.html"

        if email_request.email_type == "template" and email_request.template_name:
             template_name = email_request.template_name
        elif email_request.email_type == "custom":
             if not email_request.custom_message:
                 continue
             context["custom_message"] = email_request.custom_message
             context["subject"] = email_request.subject

        background_tasks.add_task(
            send_email,
            email_to=user.email,
            subject=email_request.subject,
            template_name=template_name,
            context=context
        )
        sent_count += 1

    return {"message": f"Emails queued for {sent_count} users"}


@router.get("/email-templates", response_model=List[str])
async def list_email_templates(
    current_admin: Admin = Depends(require_role("email_marketing")),
) -> Any:
    """
    List all available email templates (Admin with email_marketing role).
    """
    import os
    from pathlib import Path

    # Define templates directory (relative to this file: ../../../templates)
    # app/api/v1/endpoints/admin.py -> app/templates

    current_dir = Path(__file__).resolve().parent
    # Go up to app/
    app_dir = current_dir.parent.parent.parent
    template_dir = app_dir / "templates"

    if not template_dir.exists():
        return []

    templates = []
    for file in os.listdir(template_dir):
        if file.endswith(".html"):
             # Exclude base layout and potential non-email pages if necessary
             if file not in ["base.html", "404.html"]:
                 templates.append(file)

    return sorted(templates)


@router.post("/password-recovery/{email}", response_model=dict)
async def recover_password(
    email: str,
    background_tasks: BackgroundTasks,
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Password Recovery (Forgot Password).
    Sends an email with a reset link to the admin if the email exists.
    """
    service = AdminService(session)
    await service.recover_password(email, background_tasks)
    return {"message": "If this email is registered, you will receive a password reset link shortly."}


@router.post("/reset-password", response_model=dict)
async def reset_password(
    reset_data: AdminPasswordReset,
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Reset Password using a valid token.
    """
    service = AdminService(session)
    try:
        await service.reset_password(reset_data.token, reset_data.new_password)
        return {"message": "Password reset successfully"}
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))
