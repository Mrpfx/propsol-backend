import os
from dotenv import load_dotenv
from pydantic_settings import BaseSettings

load_dotenv()

class Settings(BaseSettings):
    # Database
    POSTGRES_SERVER: str = os.getenv("POSTGRES_SERVER", "localhost")
    POSTGRES_USER: str = os.getenv("POSTGRES_USER", "postgres")
    POSTGRES_PASSWORD: str = os.getenv("POSTGRES_PASSWORD", "")
    POSTGRES_DB: str = os.getenv("POSTGRES_DB", "app")
    POSTGRES_PORT: str = os.getenv("POSTGRES_PORT", "5432")

    # Railway injects DATABASE_URL; DB_URI is our own env var
    DATABASE_URL: str | None = os.getenv("DATABASE_URL")
    DB_URI: str | None = os.getenv("DB_URI")

    # Server port (Railway sets PORT automatically)
    PORT: int = int(os.getenv("PORT", "8000"))

    @property
    def db_uri(self) -> str:
        # 1. Railway's DATABASE_URL takes priority
        if self.DATABASE_URL:
            url = self.DATABASE_URL
            # Railway gives postgres:// but SQLAlchemy needs postgresql+asyncpg://
            if url.startswith("postgres://"):
                url = url.replace("postgres://", "postgresql+asyncpg://", 1)
            elif url.startswith("postgresql://"):
                url = url.replace("postgresql://", "postgresql+asyncpg://", 1)
            return url

        # 2. Explicit DB_URI from .env
        if self.DB_URI:
            return self.DB_URI

        # 3. Construct from individual Postgres parts
        if os.getenv("POSTGRES_SERVER") and os.getenv("POSTGRES_USER"):
             return f"postgresql+asyncpg://{self.POSTGRES_USER}:{self.POSTGRES_PASSWORD}@{self.POSTGRES_SERVER}:{self.POSTGRES_PORT}/{self.POSTGRES_DB}"

        # 4. Fallback to SQLite for local dev
        return "sqlite+aiosqlite:///./database.db"

    # Security
    SECRET_KEY: str | None = os.getenv("SECRET_KEY")
    ALGORITHM: str = "RS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 10080

    # RSA Keys / JWT Keys
    PRIVATE_KEY_PATH: str = os.getenv("PRIVATE_KEY_PATH", "private.pem")
    PUBLIC_KEY_PATH: str = os.getenv("PUBLIC_KEY_PATH", "public.pem")

    JWT_PRIVATE_KEY: str | None = os.getenv("JWT_PRIVATE_KEY") or os.getenv("PRIVATE_KEY")
    JWT_PUBLIC_KEY: str | None = os.getenv("JWT_PUBLIC_KEY") or os.getenv("PUBLIC_KEY")

    PRIVATE_KEY: str = ""
    PUBLIC_KEY: str = ""

    # Mailjet
    # SMTP
    SMTP_HOST: str = os.getenv("SMTP_HOST", "mail.propfirmsol.com")
    SMTP_PORT: int = int(os.getenv("SMTP_PORT", 465))
    SMTP_USER: str | None = os.getenv("SMTP_USER")
    SMTP_PASSWORD: str | None = os.getenv("SMTP_PASSWORD")
    EMAILS_FROM_EMAIL: str = os.getenv("EMAILS_FROM_EMAIL", "hello@propfirmsol.com")
    EMAILS_FROM_NAME: str = os.getenv("EMAILS_FROM_NAME", "PropFirmSol")
    ADMIN_EMAIL: str | None = os.getenv("ADMIN_EMAIL", "Hello@propfirmsol.com")

    # NOWPayments
    NOWPAYMENTS_API_KEY: str | None = os.getenv("NOWPAYMENTS_API_KEY")
    NOWPAYMENTS_IPN_SECRET: str | None = os.getenv("NOWPAYMENTS_IPN_SECRET")
    NOWPAYMENTS_API_URL: str = os.getenv("NOWPAYMENTS_API_URL", "https://api.nowpayments.io/v1")

    # Mailjet (Optional - for better deliverability)
    MAILJET_API_KEY: str | None = os.getenv("MAILJET_API_KEY")
    MAILJET_SECRET_KEY: str | None = os.getenv("MAILJET_SECRET_KEY")
    USE_MAILJET: bool = os.getenv("USE_MAILJET", "false").lower() == "true"

    # Whop
    WHOP_API_KEY: str | None = os.getenv("WHOP_API_KEY")
    WHOP_BIZ_ID: str | None = os.getenv("WHOP_BIZ_ID")
    WHOP_WEBHOOK_SECRET: str | None = os.getenv("WHOP_WEBHOOK_SECRET")

    # Email settings
    WEBSITE_URL: str = os.getenv("WEBSITE_URL", "https://propfirmsol.com")

    # Production Hardening
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "local")  # local, staging, production

    # CORS & Hosts (comma-separated strings in .env, parsed to lists here)
    # Default to "*" for local dev convenience, but enforced strict in prod
    BACKEND_CORS_ORIGINS: list[str] = [x.strip() for x in os.getenv("BACKEND_CORS_ORIGINS", "*").split(",")]
    ALLOWED_HOSTS: list[str] = [x.strip() for x in os.getenv("ALLOWED_HOSTS", "*").split(",")]

    class Config:
        env_file = ".env"
        extra = "ignore"

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        base_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

        # Load Private Key: 1. From env var (JWT_PRIVATE_KEY or PRIVATE_KEY), 2. From file (PRIVATE_KEY_PATH / private.pem)
        priv_env = os.getenv("JWT_PRIVATE_KEY") or os.getenv("PRIVATE_KEY") or self.JWT_PRIVATE_KEY
        if priv_env and priv_env.strip():
            self.PRIVATE_KEY = priv_env.replace("\\n", "\n")
        else:
            key_path = self.PRIVATE_KEY_PATH
            if not os.path.isabs(key_path):
                alt_path = os.path.join(base_dir, key_path)
                if os.path.exists(alt_path):
                    key_path = alt_path
            try:
                if os.path.exists(key_path):
                    with open(key_path, "r") as f:
                        self.PRIVATE_KEY = f.read()
                else:
                    print(f"Warning: Private key file not found at path: {key_path}")
            except Exception as e:
                print(f"Warning: Could not read private key file '{key_path}': {e}")

        # Load Public Key: 1. From env var (JWT_PUBLIC_KEY or PUBLIC_KEY), 2. From file (PUBLIC_KEY_PATH / public.pem)
        pub_env = os.getenv("JWT_PUBLIC_KEY") or os.getenv("PUBLIC_KEY") or self.JWT_PUBLIC_KEY
        if pub_env and pub_env.strip():
            self.PUBLIC_KEY = pub_env.replace("\\n", "\n")
        else:
            key_path = self.PUBLIC_KEY_PATH
            if not os.path.isabs(key_path):
                alt_path = os.path.join(base_dir, key_path)
                if os.path.exists(alt_path):
                    key_path = alt_path
            try:
                if os.path.exists(key_path):
                    with open(key_path, "r") as f:
                        self.PUBLIC_KEY = f.read()
                else:
                    print(f"Warning: Public key file not found at path: {key_path}")
            except Exception as e:
                print(f"Warning: Could not read public key file '{key_path}': {e}")

settings = Settings()
