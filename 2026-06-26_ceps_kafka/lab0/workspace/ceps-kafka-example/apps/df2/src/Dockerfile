FROM python:3.14-slim
COPY --from=ghcr.io/sikalabs/vali:v0.2.0 /usr/local/bin/vali /usr/local/bin/vali

WORKDIR /app

RUN pip install uv

COPY pyproject.toml uv.lock ./
RUN uv sync --frozen --no-dev

COPY main.py ./
COPY vali.yaml /

ENTRYPOINT ["/usr/local/bin/vali", "validate-and-run", "--"]
CMD ["uv", "run", "main.py"]
