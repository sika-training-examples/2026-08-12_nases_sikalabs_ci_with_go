#!/bin/sh

RESPONSE=$(curl -sSL -X POST "https://kc0.k8s.sikademo.com/realms/example/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=example_public" \
  -d "grant_type=password" \
  -d "username=nela" \
  -d "password=a" )

echo RAW RESPONSE:
echo $RESPONSE | jq
echo

echo PARSED ACCESS TOKEN:
PARSED_ACCESS_TOKEN=$(echo $RESPONSE | jq -r .access_token | slr parse-jwt - | jq '.[1]')
echo $PARSED_ACCESS_TOKEN | jq
echo
