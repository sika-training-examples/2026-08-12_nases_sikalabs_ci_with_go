#!/bin/sh

docker run -d -p 0.0.0.0:19092:19092 -p 0.0.0.0:19192:19192 --rm \
-v $(pwd)/lon.yml:/etc/prometheus/prometheus.yml \
--link prometheus-lon:prometheus \
--name prometheus-sidecar-lon \
-u root \
quay.io/thanos/thanos:v0.7.0 \
sidecar \
--http-address 0.0.0.0:19092 \
--grpc-address 0.0.0.0:19192 \
--reloader.config-file /etc/prometheus/prometheus.yml \
--prometheus.url http://prometheus:9092 && echo "Started sidecar for Prometheus LON"
