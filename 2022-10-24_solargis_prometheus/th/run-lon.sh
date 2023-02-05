#!/bin/sh

docker run -d -p 0.0.0.0:9092:9092 --rm \
-v $(pwd)/lon.yml:/etc/prometheus/prometheus.yml \
-u root \
--name prometheus-lon \
quay.io/thanos/prometheus:v2.12.0-rc.0-rr-streaming \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/prometheus \
--web.listen-address=:9092 \
--web.enable-lifecycle \
--web.enable-admin-api && echo "Prometheus LON started"
