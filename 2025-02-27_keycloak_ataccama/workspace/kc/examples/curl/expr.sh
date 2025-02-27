#!/bin/sh

RESPONSE=$(curl -sSL -X POST "https://kc0.k8s.sikademo.com/realms/realm1/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=default" \
  -d "client_secret=default_secret" \
  -d "grant_type=password" \
  -d "scope=openid" \
  -d "username=nela" \
  -d "password=a" )

RAW_ACCESS_TOKEN=$(echo $RESPONSE | jq -r .access_token)

curl "http://127.0.0.1/administrator" \
  -H "Authorization: Bearer $RAW_ACCESS_TOKEN" && echo


RESPONSE=$(curl -sSL -X POST "https://kc0.k8s.sikademo.com/realms/realm1/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=default" \
  -d "client_secret=default_secret" \
  -d "grant_type=password" \
  -d "scope=openid" \
  -d "username=dela" \
  -d "password=a" )

RAW_ACCESS_TOKEN=$(echo $RESPONSE | jq -r .access_token)

curl "http://127.0.0.1/administrator" \
  -H "Authorization: Bearer $RAW_ACCESS_TOKEN"
