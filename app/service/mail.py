"""
PROFESSIONAL Email Service with Maximum Deliverability

Implements industry-standard anti-spam measures:
- SPF/DKIM alignment
- Proper MIME structure
- RFC-compliant headers
- Text + HTML multipart
- Unsubscribe headers
- Domain authentication
"""
import os
import base64
import hashlib
import time
import logging
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from email.mime.image import MIMEImage
from email.utils import formataddr, make_msgid
from typing import Any, Dict
from pathlib import Path
from html import unescape
import re

from jinja2 import Environment, FileSystemLoader
from aiosmtplib import SMTP

from app.config import settings

logger = logging.getLogger(__name__)

# Setup paths
TEMPLATE_FOLDER = Path(os.path.dirname(os.path.dirname(__file__))) / 'templates'
ASSETS_FOLDER = Path(os.path.dirname(os.path.dirname(__file__))) / 'assets'

# Setup Jinja2 environment
env = Environment(loader=FileSystemLoader(TEMPLATE_FOLDER), autoescape=True)


def render_template(template_name: str, context: Dict[str, Any]) -> str:
    """Renders an HTML template using Jinja2."""
    try:
        template = env.get_template(template_name)
        return template.render(**context)
    except Exception as e:
        logger.error(f"Error rendering template {template_name}: {e}")
        return ""


def html_to_text(html: str) -> str:
    """
    Convert HTML to plain text for email fallback.
    CRITICAL: All professional emails MUST have text part for deliverability.
    """
    text = re.sub(r'<style[^>]*>.*?</style>', '', html, flags=re.DOTALL | re.IGNORECASE)
    text = re.sub(r'<script[^>]*>.*?</script>', '', text, flags=re.DOTALL | re.IGNORECASE)
    text = re.sub(r'<br\s*/?>', '\n', text, flags=re.IGNORECASE)
    text = re.sub(r'</p>', '\n\n', text, flags=re.IGNORECASE)
    text = re.sub(r'</div>', '\n', text, flags=re.IGNORECASE)
    text = re.sub(r'</h[1-6]>', '\n\n', text, flags=re.IGNORECASE)
    text = re.sub(r'</li>', '\n', text, flags=re.IGNORECASE)
    text = re.sub(r'</tr>', '\n', text, flags=re.IGNORECASE)
    text = re.sub(r'</td>', ' | ', text, flags=re.IGNORECASE)
    text = re.sub(r'<a[^>]*href=["\']([^"\']+)["\'][^>]*>([^<]+)</a>', r'\2 (\1)', text, flags=re.IGNORECASE)
    text = re.sub(r'<[^>]+>', '', text)
    text = unescape(text)
    text = re.sub(r'\n\s*\n\s*\n', '\n\n', text)
    text = re.sub(r' +', ' ', text)
    return text.strip()


async def send_email_via_mailjet(
    email_to: str,
    subject: str,
    html_content: str,
    text_content: str,
    recipient_name: str = "User"
) -> bool:
    """
    Send via Mailjet API - BEST deliverability.
    Mailjet handles SPF/DKIM/DMARC automatically.
    """
    try:
        from mailjet_rest import Client

        if not settings.MAILJET_API_KEY or not settings.MAILJET_SECRET_KEY:
            return False

        mailjet = Client(
            auth=(settings.MAILJET_API_KEY, settings.MAILJET_SECRET_KEY),
            version='v3.1'
        )

        # Unique tracking ID
        unique_id = hashlib.md5(f"{email_to}{time.time()}".encode()).hexdigest()[:12]
        custom_id = f"propsol-{unique_id}"

        # Inline logo if exists
        inlined_attachments = []
        logo_path = ASSETS_FOLDER / "logo.png"
        if logo_path.exists():
            try:
                with open(logo_path, 'rb') as f:
                    b64_content = base64.b64encode(f.read()).decode('utf-8')
                    inlined_attachments.append({
                        "ContentType": "image/png",
                        "Filename": "logo.png",
                        "ContentID": "logo",
                        "Base64Content": b64_content
                    })
            except Exception as e:
                logger.warning(f"Logo attachment failed: {e}")

        message = {
            "From": {
                "Email": settings.EMAILS_FROM_EMAIL,
                "Name": settings.EMAILS_FROM_NAME
            },
            "ReplyTo": {
                "Email": settings.EMAILS_FROM_EMAIL,
                "Name": settings.EMAILS_FROM_NAME
            },
            "To": [{
                "Email": email_to,
                "Name": recipient_name
            }],
            "Subject": subject,
            "TextPart": text_content,
            "HTMLPart": html_content,
            "CustomID": custom_id,
            "Headers": {
                "List-Unsubscribe": f"<mailto:unsubscribe@propfirmsol.com?subject=Unsubscribe>",
                "Precedence": "bulk",
                "X-Auto-Response-Suppress": "All",
                "X-Entity-Ref-ID": custom_id
            }
        }

        if inlined_attachments:
            message["InlinedAttachments"] = inlined_attachments

        result = mailjet.send.create(data={'Messages': [message]})

        if result.status_code == 200:
            logger.info(f"✓ Mailjet sent to {email_to}")
            return True
        else:
            logger.error(f"✗ Mailjet failed: {result.status_code}")
            return False

    except ImportError:
        logger.debug("mailjet_rest not installed")
        return False
    except Exception as e:
        logger.error(f"Mailjet error: {e}")
        return False


async def send_email_via_smtp(
    email_to: str,
    subject: str,
    html_content: str,
    text_content: str,
    recipient_name: str = "User"
) -> bool:
    """
    Send via SMTP with PROFESSIONAL anti-spam headers.

    Critical for deliverability:
    1. Use port 587 (STARTTLS) - more trusted than 465
    2. Proper MIME structure
    3. All RFC-compliant headers
    4. Text + HTML parts
    """
    try:
        # Create RFC-compliant message
        message = MIMEMultipart("mixed")

        # == CRITICAL HEADERS FOR DELIVERABILITY ==
        from_addr = settings.EMAILS_FROM_EMAIL
        domain = from_addr.split('@')[-1] if '@' in from_addr else 'propfirmsol.com'

        message["From"] = formataddr((settings.EMAILS_FROM_NAME, from_addr))
        message["To"] = formataddr((recipient_name, email_to))
        message["Subject"] = subject
        message["Message-ID"] = make_msgid(domain=domain)
        message["Date"] = time.strftime('%a, %d %b %Y %H:%M:%S %z')
        message["Reply-To"] = formataddr((settings.EMAILS_FROM_NAME, from_addr))

        # Anti-spam headers
        message["List-Unsubscribe"] = f"<mailto:unsubscribe@{domain}?subject=Unsubscribe>"
        message["List-Unsubscribe-Post"] = "List-Unsubscribe=One-Click"
        message["Precedence"] = "bulk"
        message["X-Auto-Response-Suppress"] = "All"
        message["X-Mailer"] = "PropSol Mailer v2.0"
        message["X-Priority"] = "3"
        message["Importance"] = "Normal"

        # Alternative part for HTML/Text
        msg_alternative = MIMEMultipart("alternative")

        # TEXT FIRST (critical!)
        msg_alternative.attach(MIMEText(text_content, "plain", "utf-8"))

        # HTML SECOND
        msg_alternative.attach(MIMEText(html_content, "html", "utf-8"))

        message.attach(msg_alternative)

        # Inline logo
        logo_path = ASSETS_FOLDER / "logo.png"
        if logo_path.exists():
            try:
                with open(logo_path, 'rb') as f:
                    img = MIMEImage(f.read(), _subtype="png")
                    img.add_header('Content-ID', '<logo>')
                    img.add_header('Content-Disposition', 'inline', filename="logo.png")
                    message.attach(img)
            except Exception as e:
                logger.warning(f"Logo attach failed: {e}")

        # Connect and send with STARTTLS (port 587 is better than 465)
        smtp_port = settings.SMTP_PORT
        use_tls = True

        # Use STARTTLS for port 587, direct TLS for 465
        if smtp_port == 587:
            async with SMTP(hostname=settings.SMTP_HOST, port=smtp_port, use_tls=False) as smtp:
                await smtp.connect()
                await smtp.starttls()
                await smtp.login(settings.SMTP_USER, settings.SMTP_PASSWORD)
                await smtp.send_message(message)
        else:
            # Port 465 - direct TLS
            async with SMTP(hostname=settings.SMTP_HOST, port=smtp_port, use_tls=True) as smtp:
                await smtp.login(settings.SMTP_USER, settings.SMTP_PASSWORD)
                await smtp.send_message(message)

        logger.info(f"✓ SMTP sent to {email_to}")
        return True

    except Exception as e:
        logger.error(f"✗ SMTP error for {email_to}: {e}")
        return False


async def send_email(
    email_to: str,
    subject: str,
    template_name: str,
    context: Dict[str, Any] = {},
) -> None:
    """
    PROFESSIONAL Email Service

    Priority: Mailjet > SMTP
    Required: Text + HTML parts, proper headers
    """
    if not settings.SMTP_HOST and not (settings.MAILJET_API_KEY and settings.USE_MAILJET):
        logger.warning(f"⚠ No email service configured for {email_to}")
        return

    # Render HTML
    html_content = render_template(template_name, context)
    if not html_content:
        logger.error(f"✗ Template render failed: {template_name}")
        return

    # Generate text version (REQUIRED for deliverability)
    text_content = html_to_text(html_content)
    text_content += f"\n\n{'='*50}\n"
    text_content += f"© 2025 PropSol. All rights reserved.\n"
    text_content += f"{settings.WEBSITE_URL}\n"
    text_content += f"To unsubscribe: {settings.WEBSITE_URL}/unsubscribe"

    recipient_name = context.get("name", context.get("user_name", "User"))

    # Try Mailjet first (BEST deliverability)
    if settings.USE_MAILJET and settings.MAILJET_API_KEY:
        if await send_email_via_mailjet(email_to, subject, html_content, text_content, recipient_name):
            print(f"Email sent to {email_to}")
            return
        logger.warning("Mailjet failed, falling back to SMTP")

    # Fallback to SMTP
    if settings.SMTP_HOST and settings.SMTP_USER:
        if await send_email_via_smtp(email_to, subject, html_content, text_content, recipient_name):
            print(f"Email sent to {email_to}")
            return

    logger.error(f"✗ All methods failed for {email_to}")
