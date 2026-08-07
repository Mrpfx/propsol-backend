from datetime import datetime
from typing import Optional
from uuid import UUID

from pydantic import BaseModel


class BannerBase(BaseModel):
    text: str
    link: Optional[str] = None
    is_active: bool = True


class BannerCreate(BannerBase):
    pass


class BannerUpdate(BaseModel):
    text: Optional[str] = None
    link: Optional[str] = None
    is_active: Optional[bool] = None


class BannerRead(BannerBase):
    id: UUID
    created_at: datetime
    updated_at: datetime
