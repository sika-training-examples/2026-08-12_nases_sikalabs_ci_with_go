#!/bin/sh

docker run -d -p 0.0.0.0:19091:19091 -p 0.0.0.0:19191:19191 --rm \
-v $(pwd)/fra.yml:/etc/prometheus/prometheus.yml \
--link prometheus-fra:prometheus \
--name prometheus-sidecar-fra \
-u root \
quay.io/thanos/thanos:v0.7.0 \
sidecar \
--http-address 0.0.0.0:19091 \
--grpc-address 0.0.0.0:19191 \
--reloader.config-file /etc/prometheus/prometheus.yml \
--prometheus.url http://prometheus:9091 && echo "Started sidecar for Prometheus FRA"
