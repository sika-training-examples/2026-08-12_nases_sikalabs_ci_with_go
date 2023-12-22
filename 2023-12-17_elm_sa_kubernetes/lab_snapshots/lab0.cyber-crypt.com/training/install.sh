#!/bin/sh

helm upgrade --install \
    counter \
    ./counter \
    --values values.yml