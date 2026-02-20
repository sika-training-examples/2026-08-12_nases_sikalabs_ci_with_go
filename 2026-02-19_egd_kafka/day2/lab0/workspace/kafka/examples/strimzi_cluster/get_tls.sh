#!/bin/sh

USER=bar

# kubectl get secret my-cluster-cluster-ca-cert -o jsonpath='{.data.ca\.crt}' | base64 -d > ca.crt

# kubectl get secret my-cluster-$USER -o jsonpath='{.data.ca\.crt}' | base64 -d > $USER-ca.crt
kubectl get secret my-cluster-$USER -o jsonpath='{.data.user\.crt}' | base64 -d > $USER.crt
kubectl get secret my-cluster-$USER -o jsonpath='{.data.user\.key}' | base64 -d > $USER.key
