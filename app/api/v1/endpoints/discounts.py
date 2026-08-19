from typing import List
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_user, get_current_admin
from app.models.user import User
from app.models.admin import Admin
from app.schema.vat_discount import (
    VatCreate, VatRead, VatUpdate,
    DiscountCodesCreate, DiscountCodesRead,
    UserDiscountCreate, UserDiscountRead,
    DiscountCodeCheckResponse
)
from app.service.vat_discount_service import VatDiscountService

router = APIRouter()

# VAT Endpoints
@router.post("/vat", response_model=VatRead)
async def create_vat(
    vat: VatCreate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    return await service.create_vat(vat)

@router.get("/vat", response_model=List[VatRead])
async def read_vats(
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    return await service.get_all_vats()

@router.put("/vat/{vat_id}", response_model=VatRead)
async def update_vat(
    vat_id: UUID,
    vat_update: VatUpdate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    updated_vat = await service.update_vat(vat_id, vat_update)
    if not updated_vat:
        raise HTTPException(status_code=404, detail="VAT not found")
    return updated_vat

@router.delete("/vat/{vat_id}", response_model=VatRead)
async def delete_vat(
    vat_id: UUID,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    deleted_vat = await service.delete_vat(vat_id)
    if not deleted_vat:
        raise HTTPException(status_code=404, detail="VAT not found")
    return deleted_vat

# Discount Codes Endpoints (Admin)
@router.post("/discounts", response_model=DiscountCodesRead)
async def create_discount_code(
    discount: DiscountCodesCreate,
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    try:
        return await service.create_discount_code(discount)
    except ValueError as e:
        raise HTTPException(status_code=400, detail=str(e))

@router.get("/discounts", response_model=List[DiscountCodesRead])
async def read_discount_codes(
    current_admin: Admin = Depends(get_current_admin),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    return await service.get_all_discounts()

# User Discount Endpoints (Apply Discount)
@router.post("/apply-discount", response_model=UserDiscountRead)
async def apply_discount(
    user_discount: UserDiscountCreate,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    try:
        return await service.apply_discount(current_user.id, user_discount.discount_code)
    except ValueError as e:
        if str(e) == "Discount code not found":
            raise HTTPException(status_code=404, detail=str(e))
        elif str(e) == "Discount code already applied":
            raise HTTPException(status_code=400, detail=str(e))
        raise HTTPException(status_code=500, detail="Internal Server Error")

@router.get("/my-discounts", response_model=List[UserDiscountRead])
async def read_my_discounts(
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    return await service.get_user_discounts(current_user.id)

@router.get("/check-usage/{code}", response_model=DiscountCodeCheckResponse)
async def check_usage(
    code: str,
    current_user: User = Depends(get_current_user),
    session: AsyncSession = Depends(get_session),
):
    service = VatDiscountService(session)
    # We need to import DiscountCodeCheckResponse... wait, it's not imported explicitly in the file yet, but I can add it to the import list or just rely on module
    # Better to add it to imports in a separate edit or verify it's available.
    # It will be in app.schema.vat_discount.
    return await service.check_usage(current_user.id, code)
