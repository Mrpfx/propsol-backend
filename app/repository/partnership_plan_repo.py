from typing import List, Optional
from uuid import UUID

from sqlmodel import select, delete
from sqlmodel.ext.asyncio.session import AsyncSession
from sqlalchemy.orm import selectinload

from app.models.partnership_plan import PartnershipPlan, PartnershipPlanPrice
from app.repository.base_repo import BaseRepository

class PartnershipPlanRepository(BaseRepository[PartnershipPlan, dict, dict]):
    """Repository for Partnership Plans"""

    def __init__(self, session: AsyncSession):
        super().__init__(PartnershipPlan, session)

    async def get_all_with_prices(self) -> List[PartnershipPlan]:
        """Get all partnership plans with prices loaded"""
        query = select(PartnershipPlan).options(selectinload(PartnershipPlan.prices)).order_by(PartnershipPlan.created_at)
        result = await self.session.exec(query)
        return result.all()

    async def get_by_slug(self, slug: str) -> Optional[PartnershipPlan]:
        """Get plan by slug"""
        query = select(PartnershipPlan).where(PartnershipPlan.slug == slug).options(selectinload(PartnershipPlan.prices))
        result = await self.session.exec(query)
        return result.first()

    async def get_with_prices(self, id: UUID) -> Optional[PartnershipPlan]:
        """Get plan by ID with prices"""
        query = select(PartnershipPlan).where(PartnershipPlan.id == id).options(selectinload(PartnershipPlan.prices))
        result = await self.session.exec(query)
        return result.first()

class PartnershipPlanPriceRepository(BaseRepository[PartnershipPlanPrice, dict, dict]):
    """Repository for Partnership Plan Prices"""

    def __init__(self, session: AsyncSession):
        super().__init__(PartnershipPlanPrice, session)

    async def delete_by_plan_id(self, plan_id: UUID):
        """Delete all prices for a plan"""
        query = delete(PartnershipPlanPrice).where(PartnershipPlanPrice.plan_id == plan_id)
        await self.session.exec(query)
        await self.session.commit()
