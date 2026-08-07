from typing import Optional, List
from uuid import UUID
from datetime import datetime
from pydantic import BaseModel, EmailStr, validator

# Shared properties
class AdminBase(BaseModel):
    email: EmailStr
    name: str
    Status: bool = True
    email_verified: bool = False
    roles: List[str] = ["dashboard"]

# Properties to receive via API on creation
class AdminCreate(AdminBase):
    password: str

# Properties to receive via API on update
class AdminUpdate(BaseModel):
    email: Optional[EmailStr] = None
    name: Optional[str] = None
    password: Optional[str] = None
    Status: Optional[bool] = None
    email_verified: Optional[bool] = None
    roles: Optional[List[str]] = None

    @validator('email', 'name', 'password', pre=True)
    def empty_str_to_none(cls, v):
        if v == "":
            return None
        return v

class AdminEmailRequest(BaseModel):
    user_ids: List[UUID] = []
    send_to_all: bool = False
    subject: str
    template_name: Optional[str] = None
    custom_message: Optional[str] = None
    email_type: str = "custom"  # "custom" or "template"

class AdminPasswordReset(BaseModel):
    token: str
    new_password: str

class AdminRead(BaseModel):
    email: EmailStr
    name: str
    Status: bool
    email_verified: bool
    roles: List[str]
    id: UUID
    created_at: datetime
    updated_at: datetime

    class Config:
        from_attributes = True
