from datetime import datetime, timezone
import uuid
from pydantic import EmailStr
from sqlalchemy import Column, DateTime
from sqlmodel import Field, SQLModel, ForeignKey, Relationship
from uuid import UUID
from enum import Enum
from sqlalchemy import Column, DateTime, JSON
from typing import List, Optional

class AdminStatus(str, Enum):
    ACTIVE = "active"
    INACTIVE = "inactive"
    SUSPENDED = "suspended"


class Admin(SQLModel, table=True):
    id: UUID = Field(primary_key=True, default_factory=uuid.uuid4)
    email: EmailStr = Field(unique=True, nullable=False, index=True)
    name: str = Field(nullable=False)
    password: str = Field(nullable=False)
    Status: bool = Field(nullable=False)
    email_verified: bool = Field(nullable=False)
    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc)
    )

    roles: List[str] = Field(sa_column=Column(JSON, nullable=False, default=["dashboard"]))

    notifications: list["Notification"] = Relationship(back_populates="admin")
