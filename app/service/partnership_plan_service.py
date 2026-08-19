from typing import List, Optional
from uuid import UUID

from sqlmodel.ext.asyncio.session import AsyncSession
from fastapi import HTTPException

from app.models.partnership_plan import PartnershipPlan, PartnershipPlanPrice
from app.repository.partnership_plan_repo import PartnershipPlanRepository, PartnershipPlanPriceRepository
from app.schema.partnership_plan import PartnershipPlanUpdate

class PartnershipPlanService:
    def __init__(self, session: AsyncSession):
        self.session = session
        self.repo = PartnershipPlanRepository(session)
        self.price_repo = PartnershipPlanPriceRepository(session)

    async def get_all_plans(self) -> List[PartnershipPlan]:
        return await self.repo.get_all_with_prices()

    async def get_plan(self, plan_id: UUID) -> Optional[PartnershipPlan]:
        return await self.repo.get_with_prices(plan_id)

    async def update_plan(self, plan_id: UUID, plan_in: PartnershipPlanUpdate) -> PartnershipPlan:
        plan = await self.repo.get_with_prices(plan_id)
        if not plan:
            raise HTTPException(status_code=404, detail="Partnership plan not found")

        # Update plan fields
        update_data = plan_in.dict(exclude_unset=True, exclude={"prices"})
        for key, value in update_data.items():
            setattr(plan, key, value)

        self.session.add(plan)

        # Update prices if provided
        if plan_in.prices is not None:
            await self.price_repo.delete_by_plan_id(plan.id)

            for price_data in plan_in.prices:
                new_price = PartnershipPlanPrice(
                    plan_id=plan.id,
                    account_size=price_data.account_size,
                    price=price_data.price,
                    account_size_display=price_data.account_size_display
                )
                self.session.add(new_price)

        await self.session.commit()
        await self.session.refresh(plan)
        return await self.repo.get_with_prices(plan.id)

    async def seed_initial_plans(self):
        """Seed initial PropSol Partnership plans if none exist"""
        existing = await self.repo.get_all()
        if existing:
            return

        plans_data = [
            {
                "slug": "partnership-challenge",
                "name": "Challenge Account Partnership",
                "subtitle": "40% Client / 60% PropSol Profit Split",
                "description": "We pass your evaluation challenge and deliver a live funded account. We handle all trading and share profits upon receiving payouts.",
                "account_type": "challenge",
                "benefits": [
                    "No upfront passing fees to PropSol",
                    "We pass both evaluation phases",
                    "MT5 investor read-only access",
                    "40% Client / 60% PropSol split on payouts"
                ],
                "is_popular": True,
                "highlight_text": "MOST CHOSEN",
                "prices": [
                    {"account_size": 50000, "price": 319.0, "account_size_display": "$50k Account"},
                    {"account_size": 90000, "price": 519.0, "account_size_display": "$90k Account"},
                    {"account_size": 100000, "price": 569.0, "account_size_display": "$100k Account"},
                    {"account_size": 200000, "price": 699.0, "account_size_display": "$200k Account"},
                    {"account_size": 500000, "price": 1999.0, "account_size_display": "$500k Account"},
                ]
            },
            {
                "slug": "partnership-instant",
                "name": "Instant Funded Partnership",
                "subtitle": "60% Client / 40% PropSol Profit Split",
                "description": "Already funded account. We begin trading immediately without an evaluation phase and share profits right away.",
                "account_type": "instant",
                "benefits": [
                    "Immediate live trading execution",
                    "No evaluation phase required",
                    "MT5 investor read-only access",
                    "60% Client / 40% PropSol split on payouts"
                ],
                "is_popular": False,
                "highlight_text": "INSTANT TRADING",
                "prices": [
                    {"account_size": 50000, "price": 499.0, "account_size_display": "$50k Account"},
                    {"account_size": 90000, "price": 799.0, "account_size_display": "$90k Account"},
                    {"account_size": 100000, "price": 899.0, "account_size_display": "$100k Account"},
                    {"account_size": 200000, "price": 1299.0, "account_size_display": "$200k Account"},
                    {"account_size": 500000, "price": 2999.0, "account_size_display": "$500k Account"},
                ]
            }
        ]

        for p_data in plans_data:
            plan = PartnershipPlan(
                slug=p_data['slug'],
                name=p_data['name'],
                subtitle=p_data['subtitle'],
                description=p_data['description'],
                account_type=p_data['account_type'],
                benefits=p_data['benefits'],
                is_popular=p_data.get('is_popular', False),
                highlight_text=p_data.get('highlight_text'),
            )
            self.session.add(plan)
            await self.session.commit()
            await self.session.refresh(plan)

            for price in p_data['prices']:
                plan_price = PartnershipPlanPrice(
                    plan_id=plan.id,
                    account_size=price['account_size'],
                    price=price['price'],
                    account_size_display=price['account_size_display']
                )
                self.session.add(plan_price)

        await self.session.commit()
