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


class PartnershipRegistrationService:
    def __init__(self, session: AsyncSession):
        self.repo = PartnershipRegistrationRepository(PartnershipRegistration, session)

    async def create_registration(self, registration_in: PartnershipRegistrationCreate, user_id: UUID) -> PartnershipRegistration:
        registration_data = registration_in.dict()
        registration_data["user_id"] = user_id
        registration_data["order_id"] = generate_order_id()
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
