#!/bin/sh

curl -i -X POST http://127.0.0.1:3100/loki/api/v1/push \
  -H "Content-Type: application/json" \
  -d '{
    "streams": [
      {
        "stream": {
          "job": "curl",
          "level": "warn",
          "instance": "0"
        },
        "values": [
          ["'$(date +%s000000000)'", "This is a warning message"]
        ]
      }
    ]
  }'
curl -i -X POST http://127.0.0.1:3100/loki/api/v1/push \
  -H "Content-Type: application/json" \
  -d '{
    "streams": [
      {
        "stream": {
          "job": "curl",
          "level": "warn",
          "instance": "1"
        },
        "values": [
          ["'$(date +%s000000000)'", "This is a warning message"]
        ]
      }
    ]
  }'
