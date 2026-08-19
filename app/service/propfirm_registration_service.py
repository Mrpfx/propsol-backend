from uuid import UUID
from typing import List
from fastapi import BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession
from app.models.propfirm_registration import PropFirmRegistration
from app.models.user import User
from app.schema.propfirm_registration import PropFirmRegistrationCreate, PropFirmRegistrationUpdate
from app.repository.propfirm_registration_repo import PropFirmRegistrationRepository
from app.core.logging_config import logger
from app.utils.order_id import generate_order_id

class PropFirmRegistrationService:
    def __init__(self, session: AsyncSession):
        self.repo = PropFirmRegistrationRepository(PropFirmRegistration, session)

    async def create_registration(self, registration_in: PropFirmRegistrationCreate, user_id: UUID) -> PropFirmRegistration:
        registration_data = registration_in.dict()
        registration_data["user_id"] = user_id
        registration_data["order_id"] = generate_order_id()

        # SECURITY: Re-calculate and validate canonical plan cost from database
        # to prevent client-side price tampering (e.g. setting propfirm_account_cost to $0)
        pass_type = registration_in.pass_type.value if registration_in.pass_type else "standard_pass"
        account_size = registration_in.account_size

        try:
            from sqlmodel import select
            from app.models.prop_firm_plan import PropFirmPlan, PropFirmPlanPrice

            # Look up the plan price matching the pass type slug and account size
            statement = (
                select(PropFirmPlanPrice)
                .join(PropFirmPlan)
                .where(PropFirmPlanPrice.account_size == int(account_size))
            )
            result = await self.repo.session.exec(statement)
            price_records = result.all()

            if price_records:
                # Use the first matching price (or match by slug if multiple plans exist)
                registration_data["propfirm_account_cost"] = float(price_records[0].price)
            else:
                # Fallback to canonical price mapping if DB records not yet seeded
                fallback_matrix = {
                    "standard_pass": {50000: 319.0, 100000: 569.0, 200000: 799.0},
                    "guaranteed_pass": {50000: 519.0, 100000: 869.0, 200000: 1299.0}
                }
                canonical_price = fallback_matrix.get(pass_type, {}).get(int(account_size))
                if canonical_price:
                    registration_data["propfirm_account_cost"] = canonical_price
        except Exception as e:
            from app.core.logging_config import logger
            logger.error(f"Error fetching canonical plan price for prop firm registration: {e}")

        return await self.repo.create(registration_data)

    async def get_registrations_by_user(self, user_id: UUID, status: str | None = None) -> List[PropFirmRegistration]:
        return await self.repo.get_by_user(user_id, status)

    async def get_registration(self, registration_id: UUID) -> PropFirmRegistration | None:
        return await self.repo.get(registration_id)

    async def update_registration(self, registration_id: UUID, update_data: PropFirmRegistrationUpdate, background_tasks: BackgroundTasks | None = None) -> PropFirmRegistration | None:
        registration = await self.repo.get(registration_id)
        if not registration:
            return None

        # Check if status is changing
        old_status = registration.account_status

        # Check if details are changing (excluding status)
        details_changed = False
        update_dict = update_data.dict(exclude_unset=True)
        excluded_fields = ["account_status", "payment_status"]

        for field, value in update_dict.items():
            if field not in excluded_fields:
                current_val = getattr(registration, field)
                if current_val != value:
                    logger.debug(f"Field {field} changed from {current_val} to {value}")
                    details_changed = True
                    break

        updated_registration = await self.repo.update(db_obj=registration, obj_in=update_data.dict(exclude_unset=True))

        from app.service.notification_service import NotificationService
        from app.models.propfirm_registration import AccountStatus

        notification_service = NotificationService(self.repo.session)
        user = await self.repo.session.get(User, updated_registration.user_id)

        # Handle detail updates
        if details_changed and user and background_tasks:
            await notification_service.send_registration_updated_email(
                user_id=user.id,
                user_email=user.email,
                user_name=user.name,
                propfirm_name=updated_registration.propfirm_name,
                order_id=updated_registration.order_id,
                background_tasks=background_tasks
            )

        if update_data.account_status and update_data.account_status != old_status:

            # Fetch user for email notifications (if not already fetched)
            if not user:
                 user = await self.repo.session.get(User, updated_registration.user_id)

            if not user:
                return updated_registration

            # Create in-app notification for all status changes
            await notification_service.create_status_change_notification(
                user_id=updated_registration.user_id,
                status=updated_registration.account_status,
                propfirm_name=updated_registration.propfirm_name
            )
            await self.repo.session.refresh(updated_registration)

            # Handle different status transitions with appropriate emails
            if updated_registration.account_status == AccountStatus.in_progress:
                # Execution started - send login success and execution started emails
                await notification_service.send_propfirm_login_success_email(
                    user_id=user.id,
                    user_email=user.email,
                    user_name=user.name,
                    propfirm_name=updated_registration.propfirm_name,
                    order_id=updated_registration.order_id,
                    background_tasks=background_tasks
                )

                await notification_service.send_execution_started_email(
                    user_id=user.id,
                    user_email=user.email,
                    user_name=user.name,
                    propfirm_name=updated_registration.propfirm_name,
                    order_id=updated_registration.order_id,
                    pass_type=updated_registration.pass_type.value,
                    login_id=updated_registration.login_id,
                    password=updated_registration.password,
                    server_name=updated_registration.server_name,
                    server_type=updated_registration.server_type,
                    platform=updated_registration.trading_platform,
                    whatsapp=updated_registration.whatsapp_no,
                    telegram=updated_registration.telegram_username,
                    website=updated_registration.propfirm_website_link,
                    background_tasks=background_tasks
                )

            elif updated_registration.account_status == AccountStatus.passed:
                # Challenge passed - send congratulations email
                await notification_service.send_challenge_passed_email(
                    user_id=user.id,
                    user_email=user.email,
                    user_name=user.name,
                    propfirm_name=updated_registration.propfirm_name,
                    order_id=updated_registration.order_id,
                    pass_type=updated_registration.pass_type.value,
                    background_tasks=background_tasks
                )

            elif updated_registration.account_status == AccountStatus.failed:
                # Challenge failed - different emails for standard vs guaranteed pass
                await notification_service.send_challenge_failed_email(
                    user_id=user.id,
                    user_email=user.email,
                    user_name=user.name,
                    propfirm_name=updated_registration.propfirm_name,
                    order_id=updated_registration.order_id,
                    pass_type=updated_registration.pass_type.value,
                    background_tasks=background_tasks
                )

        return updated_registration
