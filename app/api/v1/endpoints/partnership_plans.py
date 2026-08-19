from typing import List, Any
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_admin
from app.models.admin import Admin
from app.schema.partnership_plan import PartnershipPlanResponse, PartnershipPlanUpdate
from app.service.partnership_plan_service import PartnershipPlanService

router = APIRouter()

@router.get("", response_model=List[PartnershipPlanResponse])
async def get_partnership_plans(
    session: AsyncSession = Depends(get_session)
) -> Any:
    """
    Get all PropSol Partnership Plans with prices.
    Public endpoint.
    """
    service = PartnershipPlanService(session)
    await service.seed_initial_plans()
    return await service.get_all_plans()

@router.get("/{plan_id}", response_model=PartnershipPlanResponse)
async def get_partnership_plan(
    plan_id: UUID,
    session: AsyncSession = Depends(get_session)
) -> Any:
    """
    Get a specific Partnership Plan.
    """
    service = PartnershipPlanService(session)
    plan = await service.get_plan(plan_id)
    if not plan:
        raise HTTPException(status_code=404, detail="Partnership plan not found")
    return plan

@router.put("/{plan_id}", response_model=PartnershipPlanResponse)
async def update_partnership_plan(
    plan_id: UUID,
    plan_in: PartnershipPlanUpdate,
    session: AsyncSession = Depends(get_session),
    current_admin: Admin = Depends(get_current_admin)
) -> Any:
    """
    Update a Partnership Plan (Admin only).
    """
    service = PartnershipPlanService(session)
    return await service.update_plan(plan_id, plan_in)
