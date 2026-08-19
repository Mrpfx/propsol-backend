from datetime import datetime
from uuid import UUID
from pydantic import BaseModel

from app.schema.propfirm_registration import AccountStatus, PassType, PaymentStatus


class PartnershipRegistrationBase(BaseModel):
    login_id: str
    password: str
    propfirm_name: str
    propfirm_website_link: str = ""
    server_name: str
    server_type: str = "MT5"
    challenges_step: int = 1
    propfirm_account_cost: float = 0.0
    account_size: float = 0.0
    account_phases: int = 1
    trading_platform: str = "MT5"
    propfirm_rules: str = ""
    whatsapp_no: str = ""
    telegram_username: str = ""
    pass_type: PassType = PassType.standard_pass
    service_scope: int | None = 100
    account_status: AccountStatus = AccountStatus.pending
    payment_status: PaymentStatus = PaymentStatus.pending
    admin_notes: str | None = None


class PartnershipRegistrationCreate(PartnershipRegistrationBase):
    pass


class PartnershipRegistrationRead(PartnershipRegistrationBase):
    id: UUID
    user_id: UUID
    order_id: str
    created_at: datetime
    updated_at: datetime


class PartnershipRegistrationUpdate(BaseModel):
    login_id: str | None = None
    password: str | None = None
    propfirm_name: str | None = None
    propfirm_website_link: str | None = None
    server_name: str | None = None
    server_type: str | None = None
    challenges_step: int | None = None
    propfirm_account_cost: float | None = None
    account_size: float | None = None
    account_phases: int | None = None
    trading_platform: str | None = None
    propfirm_rules: str | None = None
    whatsapp_no: str | None = None
    telegram_username: str | None = None
    pass_type: PassType | None = None
    service_scope: int | None = None
    account_status: AccountStatus | None = None
    payment_status: PaymentStatus | None = None
    admin_notes: str | None = None

# SECURITY: Restricted schema for user self-updates on their own partnership registrations.
# Excludes account_status, payment_status, propfirm_account_cost, and admin_notes.
class UserPartnershipRegistrationUpdate(BaseModel):
    login_id: str | None = None
    password: str | None = None
    server_name: str | None = None
    server_type: str | None = None
    trading_platform: str | None = None
    whatsapp_no: str | None = None
    telegram_username: str | None = None


class PartnershipRegistrationAdminRead(PartnershipRegistrationRead):
    user_name: str
    user_email: str
