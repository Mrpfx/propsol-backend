from uuid import UUID
from typing import List, Optional
from datetime import datetime, timezone
from fastapi import BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession

from app.models.partnership_registration import PartnershipRegistration
from app.models.user import User
from app.schema.partnership_registration import (
    PartnershipRegistrationCreate,
    PartnershipRegistrationUpdate,
    PartnershipRegistrationAdminRead
)
from app.repository.partnership_registration_repo import PartnershipRegistrationRepository
from app.utils.order_id import generate_order_id
from app.core.logging_config import logger


from sqlmodel import select
from app.models.partnership_plan import PartnershipPlan, PartnershipPlanPrice

class PartnershipRegistrationService:
    def __init__(self, session: AsyncSession):
        self.session = session
        self.repo = PartnershipRegistrationRepository(PartnershipRegistration, session)

    async def create_registration(self, registration_in: PartnershipRegistrationCreate, user_id: UUID) -> PartnershipRegistration:
        registration_data = registration_in.dict()
        registration_data["user_id"] = user_id
        registration_data["order_id"] = generate_order_id()

        # SECURITY: Re-calculate and validate canonical plan cost from database to prevent URL/payload price tampering
        rules_text = (registration_in.propfirm_rules or "").lower()
        is_instant = registration_in.account_phases == 0 or registration_in.challenges_step == 0 or "instant" in rules_text
        account_type = "instant" if is_instant else "challenge"
        account_size = registration_in.account_size

        try:
            statement = (
                select(PartnershipPlanPrice)
                .join(PartnershipPlan)
                .where(PartnershipPlan.account_type == account_type)
                .where(PartnershipPlanPrice.account_size == account_size)
            )
            result = await self.session.exec(statement)
            price_record = result.first()

            if price_record and price_record.price > 0:
                registration_data["propfirm_account_cost"] = float(price_record.price)
            else:
                # Fallback to standard canonical price mapping if db record not present yet
                fallback_matrix = {
                    "challenge": {50000: 319.0, 90000: 519.0, 100000: 569.0, 200000: 699.0, 500000: 1999.0},
                    "instant": {50000: 499.0, 90000: 799.0, 100000: 899.0, 200000: 1299.0, 500000: 2999.0}
                }
                canonical_price = fallback_matrix.get(account_type, {}).get(account_size)
                if canonical_price:
                    registration_data["propfirm_account_cost"] = canonical_price
        except Exception as e:
            logger.error(f"Error fetching canonical plan price for registration: {e}")

        return await self.repo.create(registration_data)

    async def get_registrations_by_user(self, user_id: UUID, status: str | None = None) -> List[PartnershipRegistration]:
        return await self.repo.get_by_user(user_id, status)

    async def get_registration(self, registration_id: UUID) -> PartnershipRegistration | None:
        return await self.repo.get(registration_id)

    async def get_all_registrations_admin(self, status: str | None = None) -> List[PartnershipRegistrationAdminRead]:
        rows = await self.repo.get_all_with_user(status=status)
        result = []
        for reg, user in rows:
            reg_dict = reg.dict()
            reg_dict["user_name"] = user.name
            reg_dict["user_email"] = user.email
            result.append(PartnershipRegistrationAdminRead(**reg_dict))
        return result

    async def update_registration(
        self,
        registration_id: UUID,
        update_data: PartnershipRegistrationUpdate,
        background_tasks: Optional[BackgroundTasks] = None
    ) -> PartnershipRegistration | None:
        registration = await self.repo.get(registration_id)
        if not registration:
            return None

        old_status = registration.account_status
        update_dict = update_data.dict(exclude_unset=True)
        update_dict["updated_at"] = datetime.now(timezone.utc)

        updated_registration = await self.repo.update(db_obj=registration, obj_in=update_dict)

        # Send notifications if account status changes
        if update_data.account_status and update_data.account_status != old_status:
            user = await self.repo.session.get(User, updated_registration.user_id)
            if user:
                from app.service.notification_service import NotificationService
                notification_service = NotificationService(self.repo.session)
                await notification_service.create_status_change_notification(
                    user_id=updated_registration.user_id,
                    status=updated_registration.account_status,
                    propfirm_name=updated_registration.propfirm_name
                )
                await self.repo.session.refresh(updated_registration)

        return updated_registration

    async def delete_registration(self, registration_id: UUID) -> bool:
        registration = await self.repo.get(registration_id)
        if not registration:
            return False
        await self.repo.delete(registration_id)
        return True
