import uuid
from datetime import datetime, timezone
from enum import Enum
from uuid import UUID

from sqlalchemy import Column, DateTime
from sqlmodel import Field, SQLModel, ForeignKey, Relationship

class NotificationType(str, Enum):
    GENERAL = "general"
    FAILED_ACCOUNT = "failed_account"
    PASSED_ACCOUNT = "passed_account"
    LOGIN = "login"
    ACCOUNT_RESET = "account_reset"
    PASSWORD_RESET = "password_reset"

    # Payment Types
    PAYMENT_PENDING = "payment_pending"
    PAYMENT_SUCCESS = "payment_success"
    PAYMENT_FAILED = "payment_failed"
    PAYMENT_PARTIAL = "payment_partial"

    # Authentication Types
    EMAIL_VERIFIED = "email_verified"
    PASSWORD_CHANGED = "password_changed"

    # Registration Types
    REGISTRATION_CREATED = "registration_created"
    REGISTRATION_UPDATED = "registration_updated"

    # Challenge Journey Types
    CREDENTIALS_RECEIVED = "credentials_received"
    EXECUTION_STARTED = "execution_started"
    EXECUTION_PAUSED = "execution_paused"
    PROGRESS_UPDATE = "progress_update"
    TIMELINE_DELAY = "timeline_delay"
    CHALLENGE_PASSED = "challenge_passed"
    CHALLENGE_FAILED = "challenge_failed"
    CHALLENGE_QUEUED = "challenge_queued"
    TRADING_SYSTEM_ACCESS = "trading_system_access"
    CLIENT_INTERFERENCE = "client_interference"
    SERVICE_CLOSURE = "service_closure"
    UPGRADE_OFFER = "upgrade_offer"
    SUPPORT_CALL = "support_call"
    TESTIMONIAL_REQUEST = "testimonial_request"
    REENGAGEMENT = "reengagement"

class Notification(SQLModel, table=True):
    __tablename__ = "notification"
    id: UUID = Field(primary_key=True, default_factory=uuid.uuid4)
    user_id: UUID | None = Field(
        sa_column=Column(ForeignKey("user.id"), nullable=True)
    )
    admin_id: UUID | None = Field(
        sa_column=Column(ForeignKey("admin.id"), nullable=True)
    )
    title: str = Field(nullable=False)
    message: str = Field(nullable=False)
    type: NotificationType = Field(nullable=False)
    is_read: bool = Field(default=False, nullable=False)
    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )

    user: "User" = Relationship(back_populates="notifications")
    admin: "Admin" = Relationship(back_populates="notifications")
