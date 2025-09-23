FROM ghcr.io/ondrejsika/counter-frontend-go
RUN \
  apt-get update && \
  apt-get install -y --no-install-recommends curl && \
  rm -rf /var/lib/apt/lists/*
ENV FONT_COLOR="#498BA7"
ENV BACKGROUND_COLOR="#F8F8F8"
