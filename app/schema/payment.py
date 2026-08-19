from datetime import datetime
from uuid import UUID
from pydantic import BaseModel, validator


class PaymentBase(BaseModel):
    card_name: str
    card_number: str  # Will be masked before storage — only last 4 digits kept
    card_expiry_date: datetime
    card_type: str
    # SECURITY: CVV is NEVER stored. Removed to comply with PCI-DSS.
    # Payment processors should handle card data — never store raw card numbers server-side.


class PaymentCreate(PaymentBase):
    card_cvv: str | None = None  # Accepted for validation only, never persisted

    @validator('card_number')
    def mask_card_number(cls, v):
        """Only keep the last 4 digits of the card number for display purposes."""
        if v and len(v) > 4:
            return '*' * (len(v) - 4) + v[-4:]
        return v


class PaymentRead(PaymentBase):
    id: UUID
    user_id: UUID
    created_at: datetime
    updated_at: datetime


class PaymentUpdate(BaseModel):
    card_name: str | None = None
    card_number: str | None = None
    card_expiry_date: datetime | None = None
    card_type: str | None = None
    # SECURITY: CVV removed — never stored or updated
