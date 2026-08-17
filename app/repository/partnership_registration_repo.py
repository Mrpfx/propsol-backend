from uuid import UUID
from typing import List, Tuple
from sqlmodel import select
from app.models.partnership_registration import PartnershipRegistration
from app.schema.partnership_registration import PartnershipRegistrationCreate, PartnershipRegistrationUpdate
from app.repository.base_repo import BaseRepository
from app.models.user import User


class PartnershipRegistrationRepository(BaseRepository[PartnershipRegistration, PartnershipRegistrationCreate, PartnershipRegistrationUpdate]):
    async def get_by_user(self, user_id: UUID, status: str | None = None) -> List[PartnershipRegistration]:
        query = select(self.model).where(self.model.user_id == user_id)
        if status:
            query = query.where(self.model.account_status == status)
        query = query.order_by(self.model.created_at.desc())
        result = await self.session.exec(query)
        return result.all()

    async def get_by_order_id(self, order_id: str) -> PartnershipRegistration | None:
        """Find partnership registration by order_id"""
        query = select(self.model).where(self.model.order_id == order_id)
        result = await self.session.exec(query)
        return result.first()

    async def get_all_with_user(self, status: str | None = None) -> List[Tuple[PartnershipRegistration, User]]:
        """Get all partnership registrations with associated user details"""
        query = select(self.model, User).join(User, self.model.user_id == User.id)
        if status:
            query = query.where(self.model.account_status == status)
        query = query.order_by(self.model.created_at.desc())
        result = await self.session.exec(query)
        return result.all()
