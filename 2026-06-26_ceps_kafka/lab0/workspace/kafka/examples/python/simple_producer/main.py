from confluent_kafka import Producer
import time
import os


DEFAULT_BROKER_ADDR = "127.0.0.1:9092"
DEFAULT_TOPIC = "simple"

BROKER_ADDR = os.environ.get("BROKER_ADDR", DEFAULT_BROKER_ADDR)
TOPIC = os.environ.get("TOPIC", DEFAULT_TOPIC)


def main():
    p = Producer({"bootstrap.servers": BROKER_ADDR})

    i = 0
    while True:
        key = str(i)
        msg = f"simple_py_{i}"
        p.produce(TOPIC, key=key, value=msg)
        p.flush()
        print(f"produced: key={key} msg={msg}")
        i += 1
        time.sleep(1)


if __name__ == "__main__":
    main()
