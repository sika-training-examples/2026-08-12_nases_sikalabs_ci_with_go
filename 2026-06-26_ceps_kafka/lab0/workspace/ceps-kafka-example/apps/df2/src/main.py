from confluent_kafka import Producer, Consumer
import time
import os
import json
import random

BROKER_ADDR = os.environ.get("BROKER_ADDR")
TOPIC_IN = os.environ.get("TOPIC_IN")
TOPIC_OUT = os.environ.get("TOPIC_OUT")
GROUP_ID = os.environ.get("GROUP_ID")


def main():
    c = Consumer({
        "bootstrap.servers": BROKER_ADDR,
        "group.id": GROUP_ID,
        "auto.offset.reset": "earliest",
    })
    c.subscribe([TOPIC_IN])

    p = Producer({"bootstrap.servers": BROKER_ADDR})

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
        newValueJson = valueJson | {
          "hello": "Hello "+valueJson["pet_name"],
        }
        newValue = json.dumps(newValueJson)
        headers = {
          "version": "v1",
        }
        p.produce(TOPIC_OUT, key=key, value=newValue, headers=headers)
        p.flush()
        print(f"consumed: key={key}", flush=True)


if __name__ == "__main__":
    main()
