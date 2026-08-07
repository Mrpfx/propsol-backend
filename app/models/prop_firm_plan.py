import uuid
from datetime import datetime, timezone
from typing import List, Optional, Any
from sqlalchemy import Column, DateTime, JSON
from sqlmodel import Field, SQLModel, Relationship

class PropFirmPlan(SQLModel, table=True):
    __tablename__ = "prop_firm_plan"

    id: uuid.UUID = Field(
        default_factory=uuid.uuid4,
        primary_key=True,
        index=True,
        nullable=False
    )

    slug: str = Field(nullable=False, unique=True, index=True) # e.g. "2-step-step-1"
    name: str = Field(nullable=False) # e.g. "2-Step Challenge"
    subtitle: str = Field(nullable=True) # e.g. "Step 1 Pass Only"
    description: str = Field(nullable=True) # e.g. "Best for traders who want..."

    # Storing benefits/features as JSON list
    # e.g. ["You may continue Step 2 yourself", "Or upgrade later..."]
    benefits: List[str] = Field(default=[], sa_column=Column(JSON))

    # For UI ordering or highlighting
    is_popular: bool = Field(default=False)
    highlight_text: Optional[str] = Field(default=None) # e.g. "Most Popular"

    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )

    prices: List["PropFirmPlanPrice"] = Relationship(back_populates="plan", sa_relationship_kwargs={"cascade": "all, delete-orphan"})


class PropFirmPlanPrice(SQLModel, table=True):
    __tablename__ = "prop_firm_plan_price"

    id: uuid.UUID = Field(
        default_factory=uuid.uuid4,
        primary_key=True,
        index=True,
        nullable=False
    )

    plan_id: uuid.UUID = Field(foreign_key="prop_firm_plan.id", nullable=False)

    account_size: int = Field(nullable=False) # e.g. 50000
    price: float = Field(nullable=False) # e.g. 800.0

    # Optional display text for account size e.g. "$50k Account"
    account_size_display: str = Field(nullable=False)

    created_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )
    updated_at: datetime = Field(
        sa_column=Column(DateTime(timezone=True), nullable=False),
        default_factory=lambda: datetime.now(timezone.utc),
    )

    plan: PropFirmPlan = Relationship(back_populates="prices")
