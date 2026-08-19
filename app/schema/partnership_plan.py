from typing import List, Optional
import uuid
from pydantic import BaseModel

class PartnershipPlanPriceBase(BaseModel):
    account_size: int
    price: float
    account_size_display: str

class PartnershipPlanPriceCreate(PartnershipPlanPriceBase):
    pass

class PartnershipPlanPriceUpdate(PartnershipPlanPriceBase):
    pass

class PartnershipPlanPriceResponse(PartnershipPlanPriceBase):
    id: uuid.UUID
    plan_id: uuid.UUID

    class Config:
        from_attributes = True

class PartnershipPlanBase(BaseModel):
    name: str
    subtitle: Optional[str] = None
    description: Optional[str] = None
    account_type: Optional[str] = "challenge"
    benefits: Optional[List[str]] = []
    is_popular: bool = False
    highlight_text: Optional[str] = None

class PartnershipPlanCreate(PartnershipPlanBase):
    slug: str
    prices: List[PartnershipPlanPriceCreate]

class PartnershipPlanUpdate(BaseModel):
    name: Optional[str] = None
    subtitle: Optional[str] = None
    description: Optional[str] = None
    account_type: Optional[str] = None
    benefits: Optional[List[str]] = None
    is_popular: Optional[bool] = None
    highlight_text: Optional[str] = None
    prices: Optional[List[PartnershipPlanPriceCreate]] = None

class PartnershipPlanResponse(PartnershipPlanBase):
    id: uuid.UUID
    slug: str
    prices: List[PartnershipPlanPriceResponse]

    class Config:
        from_attributes = True
