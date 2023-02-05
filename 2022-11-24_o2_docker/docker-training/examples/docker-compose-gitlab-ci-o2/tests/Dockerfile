FROM python:3.11-slim
WORKDIR /test
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "-m", "unittest", "test_counter"]
