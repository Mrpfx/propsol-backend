from typing import Optional
from uuid import UUID
from datetime import datetime
from pydantic import BaseModel, EmailStr, validator

# Shared properties
class UserBase(BaseModel):
    email: EmailStr
    name: str
    Status: bool = True
    email_verified: bool = False
    referred_by: Optional[str] = None

# Properties to receive via API on creation
class UserCreate(UserBase):
    password: str

    @validator('password')
    def password_strength(cls, v):
        if len(v) < 8:
            raise ValueError('Password must be at least 8 characters')
        return v

# SECURITY: Restricted schema for user self-update (PUT /users/me)
# Does NOT include Status, email_verified, or referred_by to prevent
# privilege escalation (users cannot reactivate themselves, skip email
# verification, or set referral codes after registration).
class UserSelfUpdate(BaseModel):
    name: Optional[str] = None
    password: Optional[str] = None

    @validator('password', pre=True)
    def validate_password(cls, v):
        if v is not None and v != "" and len(v) < 8:
            raise ValueError('Password must be at least 8 characters')
        return v

# Properties to receive via API on update
class UserUpdate(BaseModel):
    email: Optional[EmailStr] = None
    name: Optional[str] = None
    password: Optional[str] = None
    Status: Optional[bool] = None
    email_verified: Optional[bool] = None
    referred_by: Optional[str] = None

class UserRead(UserBase):
    id: UUID
    referral_code: str
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
