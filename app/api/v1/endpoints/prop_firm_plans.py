from typing import List, Any
from uuid import UUID

from fastapi import APIRouter, Depends, HTTPException, Body
from sqlmodel.ext.asyncio.session import AsyncSession

from app.db.session import get_session
from app.dependencies.auth import get_current_admin
from app.models.user import User
from app.schema.prop_firm_plan import PropFirmPlanResponse, PropFirmPlanUpdate, PropFirmPlanCreate
from app.service.prop_firm_plan_service import PropFirmPlanService

router = APIRouter()

@router.get("", response_model=List[PropFirmPlanResponse])
async def get_plans(
    session: AsyncSession = Depends(get_session)
) -> Any:
    """
    Get all Prop Firm Plans with prices.
    Public endpoint (no auth required for viewing).
    """
    service = PropFirmPlanService(session)
    # Seed if empty (for dev convenience/first run)
    await service.seed_initial_plans()
    return await service.get_all_plans()

@router.get("/{plan_id}", response_model=PropFirmPlanResponse)
async def get_plan(
    plan_id: UUID,
    session: AsyncSession = Depends(get_session)
) -> Any:
    """
    Get a specific Prop Firm Plan.
    """
    service = PropFirmPlanService(session)
    plan = await service.get_plan(plan_id)
    if not plan:
        raise HTTPException(status_code=404, detail="Plan not found")
    return plan

@router.put("/{plan_id}", response_model=PropFirmPlanResponse)
async def update_plan(
    plan_id: UUID,
    plan_in: PropFirmPlanUpdate,
    session: AsyncSession = Depends(get_session),
    current_admin: User = Depends(get_current_admin)
) -> Any:
    """
    Update a Prop Firm Plan (Admin only).
    """
    service = PropFirmPlanService(session)
    return await service.update_plan(plan_id, plan_in)
