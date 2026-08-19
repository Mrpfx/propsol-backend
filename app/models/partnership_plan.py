import uuid
from datetime import datetime, timezone
from typing import List, Optional
from sqlalchemy import Column, DateTime, JSON
from sqlmodel import Field, SQLModel, Relationship

class PartnershipPlan(SQLModel, table=True):
    __tablename__ = "partnership_plan"

    id: uuid.UUID = Field(
        default_factory=uuid.uuid4,
        primary_key=True,
        index=True,
        nullable=False
    )

    slug: str = Field(nullable=False, unique=True, index=True) # e.g. "partnership-challenge"
    name: str = Field(nullable=False) # e.g. "Challenge Account Partnership"
    subtitle: str = Field(nullable=True) # e.g. "We pass your challenge & share profits"
    description: str = Field(nullable=True)
    account_type: str = Field(default="challenge", nullable=False) # "challenge" or "instant"

    # Storing benefits/features as JSON list
    benefits: List[str] = Field(default=[], sa_column=Column(JSON))

    is_popular: bool = Field(default=False)
    highlight_text: Optional[str] = Field(default=None)

    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )

    prices: List["PartnershipPlanPrice"] = Relationship(
        back_populates="plan",
        sa_relationship_kwargs={"cascade": "all, delete-orphan"}
    )


class PartnershipPlanPrice(SQLModel, table=True):
    __tablename__ = "partnership_plan_price"

    id: uuid.UUID = Field(
        default_factory=uuid.uuid4,
        primary_key=True,
        index=True,
        nullable=False
    )

    plan_id: uuid.UUID = Field(foreign_key="partnership_plan.id", nullable=False)

    account_size: int = Field(nullable=False) # e.g. 50000
    price: float = Field(nullable=False) # e.g. 319.0

    account_size_display: str = Field(nullable=False) # e.g. "$50k Account"

    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )

    plan: PartnershipPlan = Relationship(back_populates="prices")
