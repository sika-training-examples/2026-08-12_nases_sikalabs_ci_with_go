#!/bin/sh

docker run -d -p 0.0.0.0:29090:29090 --rm \
--name querier \
--link prometheus-sidecar-fra:prometheus-sidecar-fra \
--link prometheus-sidecar-lon:prometheus-sidecar-lon \
    quay.io/thanos/thanos:v0.7.0 \
    query \
    --http-address 0.0.0.0:29090 \
    --query.replica-label replica \
    --store prometheus-sidecar-lon:19191 \
    --store prometheus-sidecar-fra:19192 && echo "Started Querier"