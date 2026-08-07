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

    DB_URI: str | None = os.getenv("DB_URI")

    @property
    def db_uri(self) -> str:
        if self.DB_URI:
            return self.DB_URI

        if os.getenv("POSTGRES_SERVER") and os.getenv("POSTGRES_USER"):
             return f"postgresql+asyncpg://{self.POSTGRES_USER}:{self.POSTGRES_PASSWORD}@{self.POSTGRES_SERVER}:{self.POSTGRES_PORT}/{self.POSTGRES_DB}"

        return "sqlite+aiosqlite:///./database.db"

    # Security
    SECRET_KEY: str = os.getenv("SECRET_KEY")
    ALGORITHM: str = "RS256"
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 10080

    # RSA Keys
    PRIVATE_KEY_PATH: str = os.getenv("PRIVATE_KEY_PATH", "private.pem")
    PUBLIC_KEY_PATH: str = os.getenv("PUBLIC_KEY_PATH", "public.pem")

    PRIVATE_KEY: str = ""
    PUBLIC_KEY: str = ""

    # Mailjet
    # SMTP
    SMTP_HOST: str = os.getenv("SMTP_HOST", "mail.propfirmsol.com")
    SMTP_PORT: int = int(os.getenv("SMTP_PORT", 465))
    SMTP_USER: str = os.getenv("SMTP_USER")
    SMTP_PASSWORD: str = os.getenv("SMTP_PASSWORD")
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

    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        # Load keys
        try:
            with open(self.PRIVATE_KEY_PATH, "r") as f:
                self.PRIVATE_KEY = f.read()
            with open(self.PUBLIC_KEY_PATH, "r") as f:
                self.PUBLIC_KEY = f.read()
        except FileNotFoundError:
            print("Warning: RSA keys not found. JWT signing will fail.")

settings = Settings()
