FROM python:3.14-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1

WORKDIR /app

# Install system dependencies (needed for asyncpg/postgres)
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc libpq-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY app/ ./app/

# Railway sets PORT env var — default to 8000 for local
ENV PORT=8000

# Expose the port
EXPOSE ${PORT}

# Run with uvicorn, binding to 0.0.0.0 and Railway's PORT
CMD uvicorn app.main:app --host 0.0.0.0 --port ${PORT}
