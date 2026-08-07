from typing import List, Optional
import uuid
from pydantic import BaseModel

class PropFirmPlanPriceBase(BaseModel):
    account_size: int
    price: float
    account_size_display: str

class PropFirmPlanPriceCreate(PropFirmPlanPriceBase):
    pass

class PropFirmPlanPriceUpdate(PropFirmPlanPriceBase):
    pass

class PropFirmPlanPriceResponse(PropFirmPlanPriceBase):
    id: uuid.UUID
    plan_id: uuid.UUID

    class Config:
        from_attributes = True

class PropFirmPlanBase(BaseModel):
    name: str
    subtitle: Optional[str] = None
    description: Optional[str] = None
    benefits: Optional[List[str]] = []
    is_popular: bool = False
    highlight_text: Optional[str] = None

class PropFirmPlanCreate(PropFirmPlanBase):
    slug: str
    prices: List[PropFirmPlanPriceCreate]

class PropFirmPlanUpdate(BaseModel):
    name: Optional[str] = None
    subtitle: Optional[str] = None
    description: Optional[str] = None
    benefits: Optional[List[str]] = None
    is_popular: Optional[bool] = None
    highlight_text: Optional[str] = None
    prices: Optional[List[PropFirmPlanPriceCreate]] = None

class PropFirmPlanResponse(PropFirmPlanBase):
    id: uuid.UUID
    slug: str
    prices: List[PropFirmPlanPriceResponse]

    class Config:
        from_attributes = True
