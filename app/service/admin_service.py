from uuid import UUID
from typing import Optional, List
from fastapi import BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession
from app.models.admin import Admin
from app.models.user import User
from app.schema.admin import AdminCreate, AdminUpdate
from app.repository.admin_repo import AdminRepository
from app.repository.user_repo import UserRepository
from app.repository.transactions_repo import TransactionRepository
from app.repository.propfirm_registration_repo import PropFirmRegistrationRepository
from app.models.transactions import Transaction
from app.models.propfirm_registration import PropFirmRegistration
from app.schema.propfirm_registration import PropFirmRegistrationRead, PropFirmRegistrationUpdate, PropFirmRegistrationAdminRead
from app.service.propfirm_registration_service import PropFirmRegistrationService
from app.schema.user import UserUpdate
from app.core.security import get_password_hash

class AdminService:
    def __init__(self, session: AsyncSession):
        self.repo = AdminRepository(Admin, session)
        self.user_repo = UserRepository(User, session)
        self.transaction_repo = TransactionRepository(Transaction, session)
        self.prop_firm_repo = PropFirmRegistrationRepository(PropFirmRegistration, session)

    async def create_admin(self, admin_in: AdminCreate) -> Admin:
        admin_data = admin_in.dict()
        admin_data["password"] = get_password_hash(admin_in.password)
        return await self.repo.create(admin_data)

    async def get_admin_by_email(self, email: str) -> Optional[Admin]:
        return await self.repo.get_by_email(email)

    async def get_admin(self, admin_id: UUID) -> Optional[Admin]:
        return await self.repo.get(admin_id)

    async def get_all_admins(self, skip: int = 0, limit: int = 100) -> List[Admin]:
        return await self.repo.get_multi(skip=skip, limit=limit)

    async def update_admin(self, admin_id: UUID, admin_in: AdminUpdate) -> Optional[Admin]:
        admin = await self.repo.get(admin_id)
        if not admin:
            return None

        update_data = admin_in.dict(exclude_unset=True)
        if "password" in update_data and update_data["password"]:
            update_data["password"] = get_password_hash(update_data["password"])

        return await self.repo.update(db_obj=admin, obj_in=update_data)

    async def delete_admin(self, admin_id: UUID) -> Optional[Admin]:
        return await self.repo.delete(id=admin_id)




    async def get_all_users(self) -> List[User]:
        return await self.user_repo.get_all()

    async def get_all_transactions(self) -> List[Transaction]:
        return await self.transaction_repo.get_all()

    async def get_all_prop_firm_registrations(self) -> List[PropFirmRegistrationAdminRead]:
        results = await self.prop_firm_repo.get_all_with_user()
        registrations = []
        for reg, user in results:
            # Convert SQLModel to dict and add user info
            reg_dict = reg.dict()
            reg_dict["user_name"] = user.name if user else "Unknown"
            reg_dict["user_email"] = user.email if user else "Unknown"

            # Explicitly create the AdminRead object to ensure fields are mapped
            registrations.append(PropFirmRegistrationAdminRead(**reg_dict))
        return registrations

    async def update_user(self, user_id: UUID, user_in: UserUpdate) -> Optional[User]:
        user = await self.user_repo.get(user_id)
        if not user:
            return None
        return await self.user_repo.update(db_obj=user, obj_in=user_in)

    async def recover_password(self, email: str, background_tasks: BackgroundTasks) -> None:
        admin = await self.get_admin_by_email(email)
        if not admin:
            return

        from app.core.security import create_access_token
        from datetime import timedelta
        reset_token = create_access_token(admin.id, expires_delta=timedelta(hours=1))

        from app.service.mail import send_email
        reset_link = f"https://propfirmsol.com/reset-password?token={reset_token}"
        background_tasks.add_task(
            send_email,
            email_to=admin.email,
            subject="Admin Password Reset Request",
            template_name="reset_password.html",
            context={"name": admin.name, "reset_link": reset_link}
        )

    async def reset_password(self, token: str, new_password: str) -> None:
        from app.core.security import get_password_hash
        from jose import jwt, JWTError
        from app.config import settings

        try:
            payload = jwt.decode(token, settings.PUBLIC_KEY, algorithms=[settings.ALGORITHM])
            admin_id = payload.get("sub")
            if not admin_id:
                raise ValueError("Invalid token")
        except JWTError:
            raise ValueError("Invalid token")

        admin = await self.get_admin(UUID(admin_id))
        if not admin:
            raise ValueError("Admin not found")

        # Use update_admin which handles hashing
        from app.schema.admin import AdminUpdate
        await self.update_admin(admin.id, AdminUpdate(password=new_password))
    async def get_stats(self) -> dict:
        from sqlalchemy import func
        from sqlmodel import select
        from app.models.user import User
        from app.models.payment import Payment
        from app.models.transactions import Transaction
        from app.models.propfirm_registration import PropFirmRegistration, AccountStatus

        async def get_count(model):
            query = select(func.count(model.id))
            result = await self.repo.session.exec(query)
            return result.one() or 0

        total_users = await get_count(User)
        total_payments = await get_count(Payment)
        total_transactions = await get_count(Transaction)
        total_registrations = await get_count(PropFirmRegistration)

        # PropFirm Status Counts
        async def get_propfirm_count(status):
            query = select(func.count(PropFirmRegistration.id)).where(PropFirmRegistration.account_status == status)
            result = await self.repo.session.exec(query)
            return result.one() or 0

        propfirm_pending = await get_propfirm_count(AccountStatus.pending)
        propfirm_in_progress = await get_propfirm_count(AccountStatus.in_progress)
        propfirm_passed = await get_propfirm_count(AccountStatus.passed)
        propfirm_failed = await get_propfirm_count(AccountStatus.failed)

        # Calculate Total Revenue from successful payments or account costs
        try:
            rev_query = select(func.sum(PropFirmRegistration.propfirm_account_cost)).where(
                PropFirmRegistration.payment_status.in_(["finished", "confirmed", "completed", "successful"])
            )
            rev_result = await self.repo.session.exec(rev_query)
            total_revenue = rev_result.one_or_none() or 0
        except Exception:
            total_revenue = 0

        if not total_revenue:
            try:
                rev_query2 = select(func.sum(PropFirmRegistration.propfirm_account_cost)).where(
                    PropFirmRegistration.account_status.in_([AccountStatus.in_progress, AccountStatus.passed])
                )
                rev_result2 = await self.repo.session.exec(rev_query2)
                total_revenue = rev_result2.one_or_none() or 0
            except Exception:
                total_revenue = 0

        # Earning / Active Affiliates Count
        try:
            from app.models.affiliate import AffiliateProfile
            aff_query = select(func.count(AffiliateProfile.id)).where(AffiliateProfile.total_earnings > 0)
            aff_result = await self.repo.session.exec(aff_query)
            active_affiliates_count = aff_result.one_or_none() or 0
        except Exception:
            active_affiliates_count = 0

        return {
            "total_users": total_users,
            "total_payments": total_payments,
            "total_transactions": total_transactions,
            "total_registrations": total_registrations,
            "active_prop_firms": propfirm_in_progress + propfirm_passed,
            "pending_registrations": propfirm_pending,
            "total_revenue": float(total_revenue or 0),
            "active_affiliates_count": active_affiliates_count,
            "propfirm_stats": {
                "pending": propfirm_pending,
                "in_progress": propfirm_in_progress,
                "passed": propfirm_passed,
                "failed": propfirm_failed
            }
        }
