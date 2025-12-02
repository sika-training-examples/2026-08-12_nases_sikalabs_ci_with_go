FROM python:3.14-slim
WORKDIR /app
COPY requirements.txt .
RUN \
  pip3 install \
    --break-system-packages \
    --no-cache-dir \
    -r requirements.txt
COPY . .
CMD ["python3", "app.py"]
EXPOSE 80
