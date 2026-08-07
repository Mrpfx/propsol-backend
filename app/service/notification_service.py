from typing import List
from uuid import UUID
from fastapi import BackgroundTasks
from sqlmodel.ext.asyncio.session import AsyncSession

from app.models.notification import Notification, NotificationType
from app.repository.notification_repo import NotificationRepository
from app.schema.notification import NotificationCreate, NotificationUpdate

class NotificationService:
    def __init__(self, session: AsyncSession):
        self.repo = NotificationRepository(Notification, session)

    async def create_notification(self, notification_in: NotificationCreate) -> Notification:
        return await self.repo.create(notification_in)

    async def get_user_notifications(self, user_id: UUID) -> List[Notification]:
        return await self.repo.get_by_user(user_id)

    async def get_admin_notifications(self, admin_id: UUID) -> List[Notification]:
        return await self.repo.get_by_admin(admin_id)

    async def create_status_change_notification(self, user_id: UUID, status: str, propfirm_name: str) -> Notification:
        title = f"PropFirm Account {status.title()}"
        message = f"Your account for {propfirm_name} has been marked as {status}."
        type_map = {
            "passed": NotificationType.PASSED_ACCOUNT,
            "failed": NotificationType.FAILED_ACCOUNT,
            "pending": NotificationType.GENERAL,
            "in_progress": NotificationType.GENERAL
        }
        notification_type = type_map.get(status, NotificationType.GENERAL)

        notification_in = NotificationCreate(
            user_id=user_id,
            title=title,
            message=message,
            type=notification_type
        )
        return await self.create_notification(notification_in)

    async def _get_active_admin_emails(self) -> List[str]:
        from sqlmodel import select
        from app.models.admin import Admin

        # Assuming Status=True means active based on the boolean field in Admin model
        query = select(Admin.email).where(Admin.Status == True)
        result = await self.repo.session.exec(query)
        return result.all()

    async def send_email_to_admins(self, subject: str, template_name: str, context: dict, background_tasks: BackgroundTasks) -> None:
        from app.service.mail import send_email

        admin_emails = await self._get_active_admin_emails()
        for email in admin_emails:
            background_tasks.add_task(
                send_email,
                email_to=email,
                subject=subject,
                template_name=template_name,
                context=context
            )

    # Payment Notifications
    async def create_payment_pending_notification(self, user_id: UUID, order_id: str, amount: float) -> Notification:
        """Create notification for pending payment"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Payment Pending",
            message=f"Your payment of ${amount:.2f} for order {order_id} is being processed.",
            type=NotificationType.PAYMENT_PENDING
        )
        return await self.create_notification(notification_in)

    async def create_payment_success_notification(self, user_id: UUID, order_id: str, propfirm_name: str) -> Notification:
        """Create notification for successful payment"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Payment Successful",
            message=f"Your payment for {propfirm_name} registration has been completed successfully!",
            type=NotificationType.PAYMENT_SUCCESS
        )
        return await self.create_notification(notification_in)

    async def create_payment_failed_notification(self, user_id: UUID, order_id: str) -> Notification:
        """Create notification for failed payment"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Payment Failed",
            message=f"Your payment for order {order_id} could not be processed. Please try again.",
            type=NotificationType.PAYMENT_FAILED
        )
        return await self.create_notification(notification_in)

    async def create_payment_partial_notification(self, user_id: UUID, order_id: str) -> Notification:
        """Create notification for partially paid payment"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Partial Payment Received",
            message=f"A partial payment has been received for order {order_id}. The remaining amount is still pending.",
            type=NotificationType.PAYMENT_PARTIAL
        )
        return await self.create_notification(notification_in)

    # Authentication Notifications
    async def create_email_verified_notification(self, user_id: UUID) -> Notification:
        """Create notification for email verification"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Email Verified",
            message="Your email has been successfully verified. Welcome aboard!",
            type=NotificationType.EMAIL_VERIFIED
        )
        return await self.create_notification(notification_in)

    async def create_password_changed_notification(self, user_id: UUID) -> Notification:
        """Create notification for password change"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Password Changed",
            message="Your password has been successfully updated.",
            type=NotificationType.PASSWORD_CHANGED
        )
        return await self.create_notification(notification_in)

    # Registration Notifications
    async def create_registration_created_notification(self, user_id: UUID, propfirm_name: str, order_id: str) -> Notification:
        """Create notification for new registration"""
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Registration Created",
            message=f"Your {propfirm_name} registration has been created. Order ID: {order_id}. Please complete payment to proceed.",
            type=NotificationType.REGISTRATION_CREATED
        )
        return await self.create_notification(notification_in)



    async def send_registration_updated_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send email when registration details are updated"""
        from app.service.mail import send_email
        from app.config import settings

        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="Registration Details Updated - PropSol",
            template_name="registration_updated.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id
            }
        )

        # Notify admin
        if settings.ADMIN_EMAIL:
            from datetime import datetime
            background_tasks.add_task(
                send_email,
                email_to=settings.ADMIN_EMAIL,
                subject="[Admin] User Registration Updated",
                template_name="admin_registration_updated.html",
                context={
                    "user_name": user_name,
                    "user_email": user_email,
                    "propfirm_name": propfirm_name,
                    "order_id": order_id,
                    "registration_id": "N/A",  # Ideally passed in, but modifying signature affects callers
                    "updated_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                }
            )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Registration Updated",
            message=f"Your registration details for {propfirm_name} have been updated and verified.",
            type=NotificationType.GENERAL
        )
        await self.create_notification(notification_in)

    # ============================================
    # Customer Journey Email Triggers
    # ============================================

    async def send_credentials_received_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send email when credentials are received from client"""
        from app.service.mail import send_email
        from app.config import settings

        # Send to user
        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="Credentials Received - PropSol",
            template_name="credentials_received.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id
            }
        )

        # Notify admin
        if settings.ADMIN_EMAIL:
            from datetime import datetime
            background_tasks.add_task(
                send_email,
                email_to=settings.ADMIN_EMAIL,
                subject="[Admin] New Credentials Received",
                template_name="admin_credentials_received.html",
                context={
                    "user_name": user_name,
                    "user_email": user_email,
                    "propfirm_name": propfirm_name,
                    "order_id": order_id,
                    "created_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                }
            )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Credentials Received",
            message=f"Your credentials for {propfirm_name} have been received. Your challenge is queued for execution.",
            type=NotificationType.CREDENTIALS_RECEIVED
        )
        await self.create_notification(notification_in)

    async def send_execution_started_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        pass_type: str,
        login_id: str,
        password: str,
        server_name: str,
        server_type: str,
        platform: str,
        whatsapp: str,
        telegram: str,
        website: str,
        background_tasks: BackgroundTasks | None = None
    ) -> None:
        """Send email when execution starts on challenge"""
        from app.service.mail import send_email
        from app.config import settings
        from datetime import datetime

        # Send to user
        if background_tasks:
            background_tasks.add_task(
                send_email,
                email_to=user_email,
                subject="Execution Started - PropSol",
                template_name="execution_started.html",
                context={
                    "name": user_name,
                    "propfirm_name": propfirm_name,
                    "order_id": order_id,
                    "login_id": login_id,
                    "password": password,
                    "server_name": server_name,
                    "server_type": server_type,
                    "platform": platform,
                    "whatsapp": whatsapp,
                    "telegram": telegram,
                    "website": website
                }
            )
        else:
            await send_email(
                email_to=user_email,
                subject="Execution Started - PropSol",
                template_name="execution_started.html",
                context={
                    "name": user_name,
                    "propfirm_name": propfirm_name,
                    "order_id": order_id,
                    "login_id": login_id,
                    "password": password,
                    "server_name": server_name,
                    "server_type": server_type,
                    "platform": platform,
                    "whatsapp": whatsapp,
                    "telegram": telegram,
                    "website": website
                }
            )

        # Notify admin
        if settings.ADMIN_EMAIL:
            if background_tasks:
                background_tasks.add_task(
                    send_email,
                    email_to=settings.ADMIN_EMAIL,
                    subject="[Admin] Execution Started",
                    template_name="admin_execution_started.html",
                    context={
                        "user_name": user_name,
                        "user_email": user_email,
                        "propfirm_name": propfirm_name,
                        "order_id": order_id,
                        "pass_type": pass_type,
                        "login_id": login_id,
                        "password": password,
                        "server_name": server_name,
                        "server_type": server_type,
                        "platform": platform,
                        "whatsapp": whatsapp,
                        "telegram": telegram,
                        "website": website,
                        "started_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    }
                )
            else:
                await send_email(
                    email_to=settings.ADMIN_EMAIL,
                    subject="[Admin] Execution Started",
                    template_name="admin_execution_started.html",
                    context={
                        "user_name": user_name,
                        "user_email": user_email,
                        "propfirm_name": propfirm_name,
                        "order_id": order_id,
                        "pass_type": pass_type,
                        "login_id": login_id,
                        "password": password,
                        "server_name": server_name,
                        "server_type": server_type,
                        "platform": platform,
                        "whatsapp": whatsapp,
                        "telegram": telegram,
                        "website": website,
                        "started_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                    }
                )


        notification_in = NotificationCreate(
            user_id=user_id,
            title="Execution Started",
            message=f"Execution on your {propfirm_name} challenge has begun.",
            type=NotificationType.EXECUTION_STARTED
        )
        await self.create_notification(notification_in)

    async def send_challenge_passed_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        pass_type: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send congratulations email when challenge is passed"""
        from app.service.mail import send_email
        from app.config import settings
        from datetime import datetime

        # Send to user
        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="🎉 Congratulations - Challenge Passed!",
            template_name="challenge_passed.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id
            }
        )

        # Notify admin
        if settings.ADMIN_EMAIL:
            background_tasks.add_task(
                send_email,
                email_to=settings.ADMIN_EMAIL,
                subject="[Admin] Challenge Passed",
                template_name="admin_status_change.html",
                context={
                    "user_name": user_name,
                    "user_email": user_email,
                    "propfirm_name": propfirm_name,
                    "order_id": order_id,
                    "old_status": "in_progress",
                    "new_status": "passed",
                    "pass_type": pass_type,
                    "updated_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                }
            )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Challenge Passed!",
            message=f"Congratulations! Your {propfirm_name} challenge has been passed.",
            type=NotificationType.CHALLENGE_PASSED
        )
        await self.create_notification(notification_in)

    async def send_challenge_failed_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        pass_type: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send email when challenge fails - different templates for standard vs guaranteed pass"""
        from app.service.mail import send_email
        from app.config import settings
        from datetime import datetime

        # Choose template based on pass type
        if pass_type == "guaranteed_pass":
            template = "guaranteed_pass_refund.html"
            subject = "Challenge Update - Refund Process Initiated"
        else:
            template = "standard_pass_failed.html"
            subject = "Challenge Update - PropSol"

        # Send to user
        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject=subject,
            template_name=template,
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id
            }
        )

        # Notify admin
        if settings.ADMIN_EMAIL:
            background_tasks.add_task(
                send_email,
                email_to=settings.ADMIN_EMAIL,
                subject="[Admin] Challenge Failed",
                template_name="admin_status_change.html",
                context={
                    "user_name": user_name,
                    "user_email": user_email,
                    "propfirm_name": propfirm_name,
                    "order_id": order_id,
                    "old_status": "in_progress",
                    "new_status": "failed",
                    "pass_type": pass_type,
                    "updated_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                }
            )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Challenge Update",
            message=f"Your {propfirm_name} challenge status has been updated.",
            type=NotificationType.CHALLENGE_FAILED
        )
        await self.create_notification(notification_in)

    async def send_progress_update_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        message: str | None,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send progress update email (manual trigger by admin)"""
        from app.service.mail import send_email

        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="Challenge Progress Update - PropSol",
            template_name="progress_update.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id,
                "message": message
            }
        )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Progress Update",
            message=f"Your {propfirm_name} challenge: {message if message else 'Execution is progressing according to plan.'}",
            type=NotificationType.PROGRESS_UPDATE
        )
        await self.create_notification(notification_in)

    async def send_timeline_delay_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send timeline delay notice email"""
        from app.service.mail import send_email

        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="Timeline Update - PropSol",
            template_name="timeline_delay.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id
            }
        )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Timeline Update",
            message=f"Your {propfirm_name} challenge timeline has been updated due to market conditions.",
            type=NotificationType.TIMELINE_DELAY
        )
        await self.create_notification(notification_in)

    async def send_client_interference_warning(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send warning when client interference is detected"""
        from app.service.mail import send_email

        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="⚠️ Important Notice - Account Activity Detected",
            template_name="client_interference.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id
            }
        )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Interference Warning",
            message=f"Activity detected on your {propfirm_name} account. Please allow execution to continue uninterrupted.",
            type=NotificationType.CLIENT_INTERFERENCE
        )
        await self.create_notification(notification_in)

    async def send_payment_confirmation_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        order_id: str,
        package_name: str,
        amount: float,
        pass_type: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send payment confirmation email"""
        from app.service.mail import send_email
        from app.config import settings

        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="Payment Confirmed - PropSol",
            template_name="payment_confirmation.html",
            context={
                "name": user_name,
                "order_id": order_id,
                "package_name": package_name,
                "amount": amount,
                "pass_type": pass_type.replace("_", " ").title()
            }
        )

        # Notify admin
        if settings.ADMIN_EMAIL:
            from datetime import datetime
            background_tasks.add_task(
                send_email,
                email_to=settings.ADMIN_EMAIL,
                subject="[Admin] Payment Received",
                template_name="admin_payment_received.html",
                context={
                    "user_email": user_email,
                    "amount": amount,
                    "reference": order_id,
                    "created_at": datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                }
            )

    # Read Status Management
    async def mark_as_read(self, notification_id: UUID) -> Notification | None:
        """Mark a notification as read"""
        notification = await self.repo.get(notification_id)
        if not notification:
            return None

        update_data = NotificationUpdate(is_read=True)
        return await self.repo.update(db_obj=notification, obj_in=update_data.dict(exclude_unset=True))

    async def mark_all_as_read(self, user_id: UUID) -> int:
        """Mark all user notifications as read"""
        from sqlmodel import select, update

        stmt = (
            update(Notification)
            .where(Notification.user_id == user_id)
            .where(Notification.is_read == False)
            .values(is_read=True)
        )
        result = await self.repo.session.execute(stmt)
        await self.repo.session.commit()
        return result.rowcount

    async def send_propfirm_login_success_email(
        self,
        user_id: UUID,
        user_email: str,
        user_name: str,
        propfirm_name: str,
        order_id: str,
        background_tasks: BackgroundTasks
    ) -> None:
        """Send email when prop firm account login is successful"""
        from app.service.mail import send_email
        from app.config import settings

        background_tasks.add_task(
            send_email,
            email_to=user_email,
            subject="Prop Firm Account Login Successful - PropSol",
            template_name="propfirm_login_success.html",
            context={
                "name": user_name,
                "propfirm_name": propfirm_name,
                "order_id": order_id,
                "dashboard_url": f"{settings.WEBSITE_URL}/dashboard"
            }
        )

        # Create in-app notification
        notification_in = NotificationCreate(
            user_id=user_id,
            title="Account Login Successful",
            message=f"We have successfully logged into your {propfirm_name} account. Your challenge is now moving to execution.",
            type=NotificationType.GENERAL
        )
        await self.create_notification(notification_in)

    async def get_unread_count(self, user_id: UUID) -> int:
        """Get count of unread notifications for a user"""
        from sqlmodel import select, func

        stmt = (
            select(func.count())
            .select_from(Notification)
            .where(Notification.user_id == user_id)
            .where(Notification.is_read == False)
        )
        result = await self.repo.session.execute(stmt)
        return result.scalar() or 0
