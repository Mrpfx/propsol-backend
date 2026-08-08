from typing import Any, List
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, status
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_admin
from app.models.admin import Admin
from app.schema.booking_link import BookingLinkCreate, BookingLinkRead, BookingLinkUpdate
from app.service.booking_link_service import BookingLinkService

router = APIRouter()


@router.post("", response_model=BookingLinkRead)
async def create_booking_link(
    link_in: BookingLinkCreate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Create a new booking link (Admin only).
    """
    service = BookingLinkService(session)
    return await service.create_booking_link(link_in)


@router.get("", response_model=List[BookingLinkRead])
async def read_booking_links(
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Retrieve all booking links (Public).
    """
    service = BookingLinkService(session)
    return await service.get_all_booking_links()


@router.get("/{link_id}", response_model=BookingLinkRead)
async def read_booking_link(
    link_id: UUID,
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Retrieve a specific booking link (Public).
    """
    service = BookingLinkService(session)
    booking_link = await service.get_booking_link(link_id)
    if not booking_link:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Booking link not found",
        )
    return booking_link


@router.patch("/{link_id}", response_model=BookingLinkRead)
async def update_booking_link(
    link_id: UUID,
    link_in: BookingLinkUpdate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Update a booking link (Admin only).
    """
    service = BookingLinkService(session)
    booking_link = await service.update_booking_link(link_id, link_in)
    if not booking_link:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Booking link not found",
        )
    return booking_link


@router.delete("/{link_id}", response_model=dict)
async def delete_booking_link(
    link_id: UUID,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
) -> Any:
    """
    Delete a booking link (Admin only).
    """
    service = BookingLinkService(session)
    success = await service.delete_booking_link(link_id)
    if not success:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail="Booking link not found",
        )
    return {"detail": "Booking link deleted successfully"}
