import uuid
from datetime import datetime, timezone
from typing import TYPE_CHECKING
from uuid import UUID
from sqlalchemy import Column, DateTime
from sqlmodel import Field, SQLModel, ForeignKey, Relationship

from app.schema.propfirm_registration import PassType, AccountStatus, PaymentStatus

if TYPE_CHECKING:
    from app.models.user import User


class PartnershipRegistration(SQLModel, table=True):
    __tablename__ = "partnership_registration"

    id: UUID = Field(primary_key=True, default_factory=uuid.uuid4)
    user_id: UUID = Field(
        sa_column=Column(ForeignKey("user.id"), nullable=False)
    )
    login_id: str = Field(nullable=False)
    password: str = Field(nullable=False)
    propfirm_name: str = Field(nullable=False)
    propfirm_website_link: str = Field(nullable=False, default="")
    server_name: str = Field(nullable=False)
    server_type: str = Field(nullable=False, default="MT5")
    challenges_step: int = Field(nullable=False, default=1)
    service_scope: int = Field(nullable=True, default=100)
    order_id: str = Field(nullable=False, index=True)
    propfirm_account_cost: float = Field(nullable=False, default=0.0)
    account_size: float = Field(nullable=False, default=0.0)
    account_phases: int = Field(nullable=False, default=1)
    trading_platform: str = Field(nullable=False, default="MT5")
    propfirm_rules: str = Field(nullable=False, default="")
    whatsapp_no: str = Field(nullable=False, default="")
    telegram_username: str = Field(nullable=False, default="")
    admin_notes: str | None = Field(default=None, nullable=True)
    pass_type: PassType = Field(default=PassType.standard_pass, nullable=False)
    account_status: AccountStatus = Field(default=AccountStatus.pending, nullable=False)
    payment_status: PaymentStatus = Field(default=PaymentStatus.pending, nullable=False)
    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )

    user: 'User' = Relationship(back_populates="partnership_registrations")
