from datetime import datetime
from uuid import UUID
from pydantic import BaseModel

from enum import Enum

class AccountStatus(str, Enum):
    pending = "pending"
    in_progress = "in_progress"
    passed = "passed"
    failed = "failed"

class PassType(str, Enum):
    standard_pass = "standard_pass"
    guaranteed_pass = "guaranteed_pass"

class PaymentStatus(str, Enum):
    pending = "pending"
    completed = "completed"
    failed = "failed"

class PropFirmRegistrationBase(BaseModel):
    login_id: str
    password: str
    propfirm_name: str
    propfirm_website_link: str
    server_name: str
    server_type: str
    challenges_step: int
    propfirm_account_cost: float
    account_size: float
    account_phases: int
    trading_platform: str
    propfirm_rules: str
    whatsapp_no: str
    telegram_username: str
    pass_type: PassType = PassType.standard_pass
    service_scope: int | None = None
    account_status: AccountStatus = AccountStatus.pending
    payment_status: PaymentStatus = PaymentStatus.pending

class PropFirmRegistrationCreate(PropFirmRegistrationBase):
    pass

class PropFirmRegistrationRead(PropFirmRegistrationBase):
    id: UUID
    user_id: UUID
    order_id: str
    created_at: datetime
    updated_at: datetime

class PropFirmRegistrationUpdate(BaseModel):
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

# SECURITY: Restricted schema for user self-updates on their own registrations.
# Excludes account_status, payment_status, and propfirm_account_cost to prevent
# users from marking their own registrations as paid/passed or changing the price.
class UserPropFirmRegistrationUpdate(BaseModel):
    login_id: str | None = None
    password: str | None = None
    server_name: str | None = None
    server_type: str | None = None
    trading_platform: str | None = None
    whatsapp_no: str | None = None
    telegram_username: str | None = None

class PropFirmRegistrationAdminRead(PropFirmRegistrationRead):
    user_name: str
    user_email: str
