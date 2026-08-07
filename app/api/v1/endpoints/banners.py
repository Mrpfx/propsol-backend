from typing import Any, List
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_admin
from app.models.admin import Admin
from app.schema.banner import BannerCreate, BannerRead, BannerUpdate
from app.service.banner_service import BannerService

router = APIRouter()


@router.post("/", response_model=BannerRead)
async def create_banner(
    banner_in: BannerCreate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Create a new banner (Admin only).
    """
    service = BannerService(session)
    return await service.create_banner(banner_in)


@router.get("/", response_model=List[BannerRead])
async def read_banners(
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Retrieve all banners (Public).
    """
    service = BannerService(session)
    return await service.get_all_banners()


@router.get("/active", response_model=List[BannerRead])
async def read_active_banners(
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Retrieve all active banners (Public).
    """
    service = BannerService(session)
    return await service.get_active_banners()


@router.get("/{banner_id}", response_model=BannerRead)
async def read_banner(
    banner_id: UUID,
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Retrieve a specific banner (Public).
    """
    service = BannerService(session)
    banner = await service.get_banner(banner_id)
    if not banner:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Banner not found",
        )
    return banner


@router.patch("/{banner_id}", response_model=BannerRead)
async def update_banner(
    banner_id: UUID,
    banner_in: BannerUpdate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Update a banner (Admin only).
    """
    service = BannerService(session)
    banner = await service.update_banner(banner_id, banner_in)
    if not banner:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Banner not found",
        )
    return banner


@router.delete("/{banner_id}", response_model=dict)
async def delete_banner(
    banner_id: UUID,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Delete a banner (Admin only).
    """
    service = BannerService(session)
    success = await service.delete_banner(banner_id)
    if not success:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Banner not found",
        )
    return {"detail": "Banner deleted successfully"}
