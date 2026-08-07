from typing import List, Optional
from uuid import UUID

from sqlmodel import select, delete
from sqlmodel.ext.asyncio.session import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.prop_firm_plan import PropFirmPlan, PropFirmPlanPrice
from app.repository.base_repo import BaseRepository

class PropFirmPlanRepository(BaseRepository[PropFirmPlan, dict, dict]):
    """Repository for Prop Firm Plans"""

    def __init__(self, session: AsyncSession):
        super().__init__(PropFirmPlan, session)

    async def get_all_with_prices(self) -> List[PropFirmPlan]:
        """Get all plans with their prices loaded"""
        query = select(PropFirmPlan).options(selectinload(PropFirmPlan.prices)).order_by(PropFirmPlan.created_at)
        result = await self.session.exec(query)
        return result.all()

    async def get_by_slug(self, slug: str) -> Optional[PropFirmPlan]:
        """Get plan by slug"""
        query = select(PropFirmPlan).where(PropFirmPlan.slug == slug).options(selectinload(PropFirmPlan.prices))
        result = await self.session.exec(query)
        return result.first()

    async def get_with_prices(self, id: UUID) -> Optional[PropFirmPlan]:
        """Get plan by ID with prices"""
        query = select(PropFirmPlan).where(PropFirmPlan.id == id).options(selectinload(PropFirmPlan.prices))
        result = await self.session.exec(query)
        return result.first()

class PropFirmPlanPriceRepository(BaseRepository[PropFirmPlanPrice, dict, dict]):
    """Repository for Prop Firm Plan Prices"""

    def __init__(self, session: AsyncSession):
        super().__init__(PropFirmPlanPrice, session)

    async def delete_by_plan_id(self, plan_id: UUID):
        """Delete all prices for a plan"""
        query = delete(PropFirmPlanPrice).where(PropFirmPlanPrice.plan_id == plan_id)
        await self.session.exec(query)
        await self.session.commit()
