FROM python:3.12-slim
RUN apt-get update && \
    apt-get install -y python3-distutils python3-venv && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip install django==3.2

COPY . .

RUN python manage.py migrate
EXPOSE 8000
CMD ["python","manage.py","runserver","0.0.0.0:8000"]


