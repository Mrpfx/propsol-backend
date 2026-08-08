import asyncio
import os
import sys
import asyncpg

async def restore_dump():
    # Priority: Command line arg -> DATABASE_URL -> DB_URI -> config
    db_url = None
    if len(sys.argv) > 1 and sys.argv[1].startswith("postgres"):
        db_url = sys.argv[1]
    else:
        db_url = os.getenv("DATABASE_URL") or os.getenv("DB_URI")

    if not db_url:
        print("Error: No database URL provided.")
        print("Usage: python scripts/restore_dump.py [OPTIONAL_POSTGRES_URL]")
        print("Or set DATABASE_URL or DB_URI environment variable.")
        sys.exit(1)

    # Normalize connection string for asyncpg (must start with postgresql:// or postgres://)
    if db_url.startswith("postgresql+asyncpg://"):
        db_url = db_url.replace("postgresql+asyncpg://", "postgresql://", 1)

    dump_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "dump(1).sql")
    if not os.path.exists(dump_path):
        # Fallback to dump.sql
        dump_path = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "dump.sql")

    if not os.path.exists(dump_path):
        print(f"Error: Dump file not found at {dump_path}")
        sys.exit(1)

    print(f"Reading dump file from: {dump_path}")
    with open(dump_path, "r", encoding="utf-8", errors="ignore") as f:
        sql_script = f.read()

    print(f"Connecting to database...")
    try:
        conn = await asyncpg.connect(db_url)
        print("Connected successfully! Executing SQL dump...")
        await conn.execute(sql_script)
        await conn.close()
        print("✅ Database dump restored successfully!")
    except Exception as e:
        print(f"❌ Failed to restore database dump: {e}")
        sys.exit(1)

if __name__ == "__main__":
    asyncio.run(restore_dump())
