from typing import List, Optional
from uuid import UUID

from sqlmodel import select
from sqlmodel.ext.asyncio.session import AsyncSession

from app.models.banner import Banner
from app.schema.banner import BannerCreate, BannerUpdate


class BannerService:
    def __init__(self, session: AsyncSession):
        self.session = session

    async def create_banner(self, banner_create: BannerCreate) -> Banner:
        banner = Banner.from_orm(banner_create)
        self.session.add(banner)
        await self.session.commit()
        await self.session.refresh(banner)
        return banner

    async def get_banner(self, banner_id: UUID) -> Optional[Banner]:
        return await self.session.get(Banner, banner_id)

    async def get_all_banners(self) -> List[Banner]:
        query = select(Banner)
        result = await self.session.exec(query)
        return result.all()

    async def get_active_banners(self) -> List[Banner]:
        query = select(Banner).where(Banner.is_active == True)
        result = await self.session.exec(query)
        return result.all()

    async def update_banner(
        self, banner_id: UUID, banner_update: BannerUpdate
    ) -> Optional[Banner]:
        banner = await self.get_banner(banner_id)
        if not banner:
            return None

        update_data = banner_update.dict(exclude_unset=True)
        for key, value in update_data.items():
            setattr(banner, key, value)

        self.session.add(banner)
        await self.session.commit()
        await self.session.refresh(banner)
        return banner

    async def delete_banner(self, banner_id: UUID) -> bool:
        banner = await self.get_banner(banner_id)
        if not banner:
            return False

        await self.session.delete(banner)
        await self.session.commit()
        return True
