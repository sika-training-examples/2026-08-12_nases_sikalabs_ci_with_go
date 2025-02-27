#!/bin/sh

RESPONSE=$(curl -sSL -X POST "https://kc0.k8s.sikademo.com/realms/realm1/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=default" \
  -d "client_secret=default_secret" \
  -d "grant_type=password" \
  -d "scope=openid department profile email" \
  -d "username=dela" \
  -d "password=a" )

echo RAW RESPONSE:
echo $RESPONSE | jq
echo

echo PARSED ACCESS TOKEN:
PARSED_ACCESS_TOKEN=$(echo $RESPONSE | jq -r .access_token | slr parse-jwt - | jq '.[1]')
echo $PARSED_ACCESS_TOKEN | jq
echo

echo PARSED ID TOKEN:
PARSED_ID_TOKEN=$(echo $RESPONSE | jq -r .id_token | slr parse-jwt - | jq '.[1]')
echo $PARSED_ID_TOKEN | jq
echo
