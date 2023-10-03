ARG PYTHON_VERSION=3.11-slim
FROM python:${PYTHON_VERSION}
WORKDIR /app
COPY requirements.txt .
RUN pip3 install -r requirements.txt --break-system-packages --no-cache-dir
COPY . .
CMD ["python3", "app.py", "aa"]
EXPOSE 80
