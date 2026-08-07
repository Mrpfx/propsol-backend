import uuid
from datetime import datetime, timezone
from typing import Optional
from uuid import UUID

from sqlalchemy import Column, DateTime
from sqlmodel import SQLModel, Field


class Banner(SQLModel, table=True):
    __tablename__ = "banner"

    id: UUID = Field(primary_key=True, default_factory=uuid.uuid4)
    text: str = Field(nullable=False)
    link: Optional[str] = Field(default=None)
    is_active: bool = Field(default=True)
    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )
