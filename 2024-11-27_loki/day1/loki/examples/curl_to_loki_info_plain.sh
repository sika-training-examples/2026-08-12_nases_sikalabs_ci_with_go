#!/bin/sh

curl -i -X POST http://127.0.0.1:3100/loki/api/v1/push \
  -H "Content-Type: application/json" \
  -d '{
    "streams": [
      {
        "stream": {
          "job": "curl",
          "foo": "bar"
        },
        "values": [
          ["'$(date +%s000000000)'", "INFO This is a log message sent to Loki using curl"]
        ]
      }
    ]
  }'
