from typing import List, Any
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_user, get_current_admin
from app.models.user import User
from app.models.admin import Admin
from app.schema.partnership_registration import (
    PartnershipRegistrationCreate,
    PartnershipRegistrationRead,
    PartnershipRegistrationUpdate,
    PartnershipRegistrationAdminRead,
    UserPartnershipRegistrationUpdate
)
from app.service.partnership_registration_service import PartnershipRegistrationService

router = APIRouter()


# -------------------------------------------------------------------
# User Endpoints
# -------------------------------------------------------------------

@router.post("", response_model=PartnershipRegistrationRead)
@router.post("/register", response_model=PartnershipRegistrationRead)
async def create_partnership_registration(
    registration: PartnershipRegistrationCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
    background_tasks: BackgroundTasks = BackgroundTasks(),
):
    """Create a new partnership registration for the current user."""
    service = PartnershipRegistrationService(session)
    return await service.create_registration(registration, current_user.id)


@router.get("", response_model=List[PartnershipRegistrationRead])
@router.get("/my-accounts", response_model=List[PartnershipRegistrationRead])
async def read_user_partnership_registrations(
    status: str | None = None,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    """Get all partnership registrations for the current user."""
    service = PartnershipRegistrationService(session)
    return await service.get_registrations_by_user(current_user.id, status)


@router.get("/{registration_id}", response_model=PartnershipRegistrationRead)
async def read_user_partnership_registration(
    registration_id: UUID,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    """Get a specific partnership registration for the current user."""
    service = PartnershipRegistrationService(session)
    registration = await service.get_registration(registration_id)
    if not registration or registration.user_id != current_user.id:
        raise HTTPException(status_code=404, detail="Partnership registration not found")
    return registration


# SECURITY: Uses UserPartnershipRegistrationUpdate (not PartnershipRegistrationUpdate)
# to prevent users from modifying account_status, payment_status, or propfirm_account_cost.
@router.patch("/{registration_id}", response_model=PartnershipRegistrationRead)
async def update_user_partnership_registration(
    registration_id: UUID,
    registration_in: UserPartnershipRegistrationUpdate,
    background_tasks: BackgroundTasks,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    """Update credentials or contact info of current user's partnership registration."""
    service = PartnershipRegistrationService(session)
    registration = await service.get_registration(registration_id)

    if not registration or registration.user_id != current_user.id:
        raise HTTPException(status_code=404, detail="Partnership registration not found")

    # Convert restricted schema to full update schema (only fields user is allowed to change)
    update_data = PartnershipRegistrationUpdate(**registration_in.dict(exclude_unset=True))

    updated = await service.update_registration(
        registration_id=registration_id,
        update_data=update_data,
        background_tasks=background_tasks
    )
    return updated


# -------------------------------------------------------------------
# Admin Endpoints
# -------------------------------------------------------------------

@router.get("/admin/all", response_model=List[PartnershipRegistrationAdminRead])
async def admin_read_all_partnership_registrations(
    status: str | None = None,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    """Retrieve all partnership registrations for admin oversight."""
    service = PartnershipRegistrationService(session)
    return await service.get_all_registrations_admin(status=status)


@router.get("/admin/{registration_id}", response_model=PartnershipRegistrationAdminRead)
async def admin_read_partnership_registration(
    registration_id: UUID,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    """Get details of a single partnership registration for admin."""
    service = PartnershipRegistrationService(session)
    registration = await service.get_registration(registration_id)
    if not registration:
        raise HTTPException(status_code=404, detail="Partnership registration not found")

    user = await session.get(User, registration.user_id)
    reg_dict = registration.dict()
    reg_dict["user_name"] = user.name if user else "Unknown"
    reg_dict["user_email"] = user.email if user else "Unknown"
    return PartnershipRegistrationAdminRead(**reg_dict)


@router.put("/admin/{registration_id}", response_model=PartnershipRegistrationRead)
@router.patch("/admin/{registration_id}", response_model=PartnershipRegistrationRead)
async def admin_update_partnership_registration(
    registration_id: UUID,
    registration_in: PartnershipRegistrationUpdate,
    background_tasks: BackgroundTasks,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    """Full control admin update of partnership registration details/status."""
    service = PartnershipRegistrationService(session)
    updated = await service.update_registration(
        registration_id=registration_id,
        update_data=registration_in,
        background_tasks=background_tasks
    )
    if not updated:
        raise HTTPException(status_code=404, detail="Partnership registration not found")
    return updated


@router.delete("/admin/{registration_id}", response_model=dict)
async def admin_delete_partnership_registration(
    registration_id: UUID,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    """Delete a partnership registration record (Admin only)."""
    service = PartnershipRegistrationService(session)
    deleted = await service.delete_registration(registration_id)
    if not deleted:
        raise HTTPException(status_code=404, detail="Partnership registration not found")
    return {"message": "Partnership registration deleted successfully"}
