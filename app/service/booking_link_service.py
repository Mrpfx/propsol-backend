from typing import List, Optional
from uuid import UUID

from sqlmodel import select
from sqlmodel.ext.asyncio.session import AsyncSession

from app.models.booking_link import BookingLink
from app.schema.booking_link import BookingLinkCreate, BookingLinkUpdate


class BookingLinkService:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create_booking_link(self, link_create: BookingLinkCreate) -> BookingLink:
        booking_link = BookingLink.from_orm(link_create)
        self.session.add(booking_link)
        await self.session.commit()
        await self.session.refresh(booking_link)
        return booking_link

    async def get_booking_link(self, link_id: UUID) -> Optional[BookingLink]:
        return await self.session.get(BookingLink, link_id)

    async def get_all_booking_links(self) -> List[BookingLink]:
        query = select(BookingLink)
        result = await self.session.exec(query)
        return result.all()

    async def update_booking_link(
        self, link_id: UUID, link_update: BookingLinkUpdate
    ) -> Optional[BookingLink]:
        booking_link = await self.get_booking_link(link_id)
        if not booking_link:
            return None

        update_data = link_update.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(booking_link, key, value)

        self.session.add(booking_link)
        await self.session.commit()
        await self.session.refresh(booking_link)
        return booking_link

    async def delete_booking_link(self, link_id: UUID) -> bool:
        booking_link = await self.get_booking_link(link_id)
        if not booking_link:
            return False

        await self.session.delete(booking_link)
        await self.session.commit()
        return True
