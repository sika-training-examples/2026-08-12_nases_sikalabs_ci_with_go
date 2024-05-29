FROM python:3.11-slim
WORKDIR /app
COPY . .
RUN pip3 install -r requirements.txt --break-system-packages --no-cache-dir
CMD ["python3", "app.py"]
EXPOSE 80