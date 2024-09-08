FROM python:3.11

# Install dependencies
RUN apt-get update && \
    apt-get install -y python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /opt/app

# Copy your application files
COPY . .

# Install necessary Python packages directly (replace with your actual packages)
RUN python -m pip install --upgrade pip
RUN pip install django==3.2  # Add other packages here if needed

# Run database migrations and start the application
RUN python manage.py migrate

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
