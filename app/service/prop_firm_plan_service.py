from typing import List, Optional
from uuid import UUID

from sqlmodel.ext.asyncio.session import AsyncSession
from fastapi import HTTPException

from app.models.prop_firm_plan import PropFirmPlan, PropFirmPlanPrice
from app.repository.prop_firm_plan_repo import PropFirmPlanRepository, PropFirmPlanPriceRepository
from app.schema.prop_firm_plan import PropFirmPlanCreate, PropFirmPlanUpdate, PropFirmPlanPriceCreate

class PropFirmPlanService:
    def __init__(self, session: AsyncSession):
        self.session = session
        self.repo = PropFirmPlanRepository(session)
        self.price_repo = PropFirmPlanPriceRepository(session)

    async def get_all_plans(self) -> List[PropFirmPlan]:
        return await self.repo.get_all_with_prices()

    async def get_plan(self, plan_id: UUID) -> Optional[PropFirmPlan]:
        return await self.repo.get_with_prices(plan_id)

    async def update_plan(self, plan_id: UUID, plan_in: PropFirmPlanUpdate) -> PropFirmPlan:
        plan = await self.repo.get_with_prices(plan_id)
        if not plan:
            raise HTTPException(status_code=404, detail="Plan not found")

        # Update plan fields
        update_data = plan_in.dict(exclude_unset=True, exclude={"prices"})
        for key, value in update_data.items():
            setattr(plan, key, value)

        self.session.add(plan)

        # Update prices if provided
        if plan_in.prices is not None:
             # Delete existing prices (easiest way to handle full update)
             # Or we could try to diff them, but full replace is safer for admin edits
             await self.price_repo.delete_by_plan_id(plan.id)

             for price_data in plan_in.prices:
                 new_price = PropFirmPlanPrice(
                     plan_id=plan.id,
                     account_size=price_data.account_size,
                     price=price_data.price,
                     account_size_display=price_data.account_size_display
                 )
                 self.session.add(new_price)

        await self.session.commit()
        await self.session.refresh(plan)
        # Re-fetch with prices loaded
        return await self.repo.get_with_prices(plan.id)

    async def seed_initial_plans(self):
        """Seed initial plans if none exist"""
        existing = await self.repo.get_all()
        if existing:
            return

        # Data from screenshots
        plans_data = [
            {
                "slug": "2-step-step-1",
                "name": "2-Step Challenge",
                "subtitle": "Step 1 Pass Only",
                "description": "Best for traders who want help clearing the first stage. We handle Step 1 only. After passing, control is returned to you.",
                "benefits": ["You may continue Step 2 yourself", "Or upgrade later to full completion"],
                "is_popular": False,
                "prices": [
                    {"account_size": 50000, "price": 800.0, "account_size_display": "$50k Account"},
                    {"account_size": 100000, "price": 1200.0, "account_size_display": "$100k Account"},
                    {"account_size": 200000, "price": 1700.0, "account_size_display": "$200k Account"},
                    {"account_size": 500000, "price": 2500.0, "account_size_display": "$500k Account"},
                ]
            },
            {
                "slug": "2-step-full",
                "name": "2-Step Challenge",
                "subtitle": "Full (Step 1 + Step 2)",
                "description": "Best for traders who want the entire challenge completed. We complete both Step 1 and Step 2, then return the passed account to you.",
                "benefits": ["Optional access to the PropSol Trading System for funded trading support"],
                "is_popular": True,
                "highlight_text": "MOST CHOSEN",
                "prices": [
                    {"account_size": 50000, "price": 1100.0, "account_size_display": "$50k Account"},
                    {"account_size": 100000, "price": 1600.0, "account_size_display": "$100k Account"},
                    {"account_size": 200000, "price": 2200.0, "account_size_display": "$200k Account"},
                    {"account_size": 500000, "price": 3200.0, "account_size_display": "$500k Account"},
                ]
            },
            {
                "slug": "1-step-full",
                "name": "1-Step Challenge",
                "subtitle": "Full",
                "description": "Best for firms with single-phase challenges. We complete the entire 1-Step challenge in one structured phase.",
                "benefits": ["Funded account returned to you", "Optional access to the PropSol Trading System"],
                "is_popular": False,
                "prices": [
                    {"account_size": 50000, "price": 1400.0, "account_size_display": "$50k Account"},
                    {"account_size": 100000, "price": 1900.0, "account_size_display": "$100k Account"},
                    {"account_size": 200000, "price": 2600.0, "account_size_display": "$200k Account"},
                    {"account_size": 500000, "price": 3800.0, "account_size_display": "$500k Account"},
                ]
            }
        ]

        # Standard Pass (No Refund)
        for p_data in plans_data:
            plan = PropFirmPlan(
                slug=f"guaranteed-{p_data['slug']}",
                name=p_data['name'],
                subtitle=p_data['subtitle'],
                description=p_data['description'],
                benefits=p_data['benefits'],
                is_popular=p_data.get('is_popular', False),
                highlight_text=p_data.get('highlight_text'),
                # Add pass_type logic later if models differ, for now just seed content
            )
            self.session.add(plan)
            await self.session.commit()
            await self.session.refresh(plan)

            for price in p_data['prices']:
                # Guaranteed pass prices
                plan_price = PropFirmPlanPrice(
                    plan_id=plan.id,
                    account_size=price['account_size'],
                    price=price['price'],
                    account_size_display=price['account_size_display']
                )
                self.session.add(plan_price)

            # Create Standard version (cheaper)
            # Standard prices (extracted from screenshot 2)
            # Step 1 Only: 490, 690, 990, 1390
            # Full 2-Step: 690, 890, 1290, 1790
            # 1-Step Full: 1400, 1900, 2600, 3800 (Same? No, third screenshot shows exact same prices for 1-step logic? Wait.)
            # Screenshot 2 says "Standard Pass ... No Refund Guarantee".
            # Screenshot 1 says "Guaranteed Pass ... Full refund protection".

            # Let's approximate standard prices based on screenshot 2
            standard_prices = []
            if p_data['slug'] == "2-step-step-1":
                 standard_prices = [490, 690, 990, 1390]
            elif p_data['slug'] == "2-step-full":
                 standard_prices = [690, 890, 1290, 1790]
            elif p_data['slug'] == "1-step-full":
                 standard_prices = [1400, 1900, 2600, 3800] # Seems same in screenshot 3? Or is screenshot 3 just the same as 1 but 1-step focused?
                 # Actually Screenshot 2 (Standard Pass) 1-Step column shows: 1400, 1900, 2600, 3800.
                 # Screenshot 1 (Guaranteed Pass) 1-Step column shows: 1400, 1900, 2600, 3800.
                 # Wait, they are the same? That's odd. Maybe Guaranteed is not available for 1-step?
                 # Or maybe the user just sent duplicate screenshot content? I will assume standard pricing for 1-step matches screenshot 2.

            plan_standard = PropFirmPlan(
                slug=f"standard-{p_data['slug']}",
                name=p_data['name'],
                subtitle=p_data['subtitle'],
                description=p_data['description'],
                benefits=p_data['benefits'],
                is_popular=p_data.get('is_popular', False),
                highlight_text=p_data.get('highlight_text'),
            )
            self.session.add(plan_standard)
            await self.session.commit()
            await self.session.refresh(plan_standard)

            for i, price in enumerate(p_data['prices']):
                std_price_val = standard_prices[i] if i < len(standard_prices) else price['price']
                plan_price = PropFirmPlanPrice(
                    plan_id=plan_standard.id,
                    account_size=price['account_size'],
                    price=std_price_val,
                    account_size_display=price['account_size_display']
                )
                self.session.add(plan_price)

        await self.session.commit()
