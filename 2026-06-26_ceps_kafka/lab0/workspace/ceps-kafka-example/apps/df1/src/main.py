from confluent_kafka import Producer
import time
import os
import json
import random


BROKER_ADDR = os.environ.get("BROKER_ADDR")
TOPIC = os.environ.get("TOPIC")


def main():
    p = Producer({"bootstrap.servers": BROKER_ADDR})

    i = 0
    while True:
        key = os.environ.get("HOSTNAME") + "-" + str(i)
        msg = json.dumps({
          "i": i,
          "hostname": os.environ.get("HOSTNAME"),
          "pet_name": random.choice(["Dela", "Nela"]),
          "pet_kind": random.choice(["dog", "cat"]),
        })
        headers = {
          "version": "v1",
        }
        p.produce(TOPIC, key=key, value=msg, headers=headers)
        p.flush()
        print(f"produced: key={key} msg={msg}", flush=True)
        i += 1
        time.sleep(1)


if __name__ == "__main__":
    main()
