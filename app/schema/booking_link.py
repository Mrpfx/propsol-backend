from datetime import datetime
from typing import Optional
from uuid import UUID

from pydantic import BaseModel, HttpUrl


class BookingLinkBase(BaseModel):
    title: str
    url: str
    is_active: bool = True


class BookingLinkCreate(BookingLinkBase):
    pass


class BookingLinkUpdate(BaseModel):
    title: Optional[str] = None
    url: Optional[str] = None
    is_active: Optional[bool] = None


class BookingLinkRead(BookingLinkBase):
    id: UUID
    created_at: datetime
    updated_at: datetime
