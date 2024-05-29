FROM python:3.11-slim
WORKDIR /app
RUN \
    apt-get update && \
    apt-get install -y --no-install-recommends git && \
    rm -rf /var/lib/apt/lists/*
COPY requirements.txt .
RUN pip3 install -r requirements.txt --break-system-packages --no-cache-dir
RUN git init
COPY . .
CMD ["python3", "app.py"]
EXPOSE 80
