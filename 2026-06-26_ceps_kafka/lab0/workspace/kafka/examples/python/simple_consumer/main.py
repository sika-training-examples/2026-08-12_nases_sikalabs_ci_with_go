from confluent_kafka import Consumer
import os


DEFAULT_BROKER_ADDR = "127.0.0.1:9092"
DEFAULT_TOPIC = "simple"
DEFAULT_GROUP_ID = "simple_py"

BROKER_ADDR = os.environ.get("BROKER_ADDR", DEFAULT_BROKER_ADDR)
TOPIC = os.environ.get("TOPIC", DEFAULT_TOPIC)
GROUP_ID = os.environ.get("GROUP_ID", DEFAULT_GROUP_ID)


def main():
    c = Consumer({
        "bootstrap.servers": BROKER_ADDR,
        "group.id": GROUP_ID,
        "auto.offset.reset": "earliest",
    })
    c.subscribe([TOPIC])

    while True:
        msg = c.poll(1.0)
        if msg is None:
            continue
        if msg.error():
            print(f"error: {msg.error()}")
            continue
        key = msg.key().decode() if msg.key() else ""
        value = msg.value().decode() if msg.value() else ""
        print(f"consumed: key={key} msg={value}")


if __name__ == "__main__":
    main()
