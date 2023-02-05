#!/bin/sh

docker run -d -p 0.0.0.0:9091:9091 --rm \
-v $(pwd)/fra.yml:/etc/prometheus/prometheus.yml \
-u root \
--name prometheus-fra \
quay.io/thanos/prometheus:v2.12.0-rc.0-rr-streaming \
--config.file=/etc/prometheus/prometheus.yml \
--storage.tsdb.path=/prometheus \
--web.listen-address=:9091 \
--web.enable-lifecycle \
--web.enable-admin-api && echo "Prometheus FRA started"
