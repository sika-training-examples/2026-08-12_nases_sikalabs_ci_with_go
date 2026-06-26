from confluent_kafka import Consumer
import time
import os
import json
import random

BROKER_ADDR = os.environ.get("BROKER_ADDR")
TOPIC_IN = os.environ.get("TOPIC_IN")
GROUP_ID = os.environ.get("GROUP_ID")


def main():
    c = Consumer({
        "bootstrap.servers": BROKER_ADDR,
        "group.id": GROUP_ID,
        "auto.offset.reset": "earliest",
    })
    c.subscribe([TOPIC_IN])

    while True:
        msg = c.poll(1.0)
        if msg is None:
            continue
        if msg.error():
            print(f"error: {msg.error()}")
            continue
        key = msg.key().decode() if msg.key() else ""
        value = msg.value().decode() if msg.value() else ""
        valueJson = json.loads(value)
        print(f"consumed: key={key} msg={value}")
        if valueJson["pet_name"] == "Dela" and valueJson["pet_kind"] == "dog":
          print(f"!!! Hello Dela !!!", flush=True)

if __name__ == "__main__":
    main()
