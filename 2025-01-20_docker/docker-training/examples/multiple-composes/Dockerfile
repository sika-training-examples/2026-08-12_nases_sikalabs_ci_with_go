FROM python:3.12-slim
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    curl && \
  rm -rf /var/lib/apt
WORKDIR /app
COPY requirements.txt .
RUN pip3 install --break-system-packages -r requirements.txt --no-cache-dir
COPY . .
CMD ["python3", "app.py"]
EXPOSE 80
