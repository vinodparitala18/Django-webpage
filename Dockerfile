# Base Image
FROM python:3.12-slim

# Prevents python from writing pyc files
ENV PYTHONDONTWRITEBYTECODE=1

# Prevents buffering
ENV PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Copy requirements first
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Expose port
EXPOSE 8000

# Run migrations
RUN python manage.py migrate

# Start server
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "myproject.wsgi:application"]
