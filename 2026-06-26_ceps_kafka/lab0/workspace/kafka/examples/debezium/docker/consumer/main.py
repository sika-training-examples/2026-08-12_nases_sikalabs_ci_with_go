import json
import os

from confluent_kafka import Consumer, KafkaException

BOOTSTRAP_SERVERS = os.getenv("BOOTSTRAP_SERVERS", "ceps-kafka-bootstrap.kafka.svc:9092")
GROUP_ID = os.getenv("GROUP_ID", "debezium-consumer")
# regex: subscribe to all debezium topics
TOPICS_PATTERN = os.getenv("TOPICS_PATTERN", "^dbz\\..*")

OP_LABELS = {
    "c": "INSERT",
    "u": "UPDATE",
    "d": "DELETE",
    "r": "READ",
}


def parse_json_field(value):
    if isinstance(value, str):
        try:
            return json.loads(value)
        except (json.JSONDecodeError, TypeError):
            pass
    return value


def format_fields(record):
    if not record:
        return ""
    skip = {"created_at", "schema"}
    return " ".join(f"{k}={v}" for k, v in record.items() if k not in skip)


def handle_message(topic, payload):
    op = payload.get("op")
    label = OP_LABELS.get(op, op or "UNKNOWN")
    before = parse_json_field(payload.get("before"))
    after = parse_json_field(payload.get("after"))

    record = after if after is not None else before

    if op == "u" and before and after:
        changed = {k: v for k, v in after.items() if before.get(k) != v and k != "created_at"}
        changed_str = ", ".join(f"{k}: {before.get(k)!r} -> {v!r}" for k, v in changed.items())
        print(f"[{label}] {topic} | {format_fields(record)} | changed: {changed_str}", flush=True)
    else:
        print(f"[{label}] {topic} | {format_fields(record)}", flush=True)


def main():
    consumer = Consumer({
        "bootstrap.servers": BOOTSTRAP_SERVERS,
        "group.id": GROUP_ID,
        "auto.offset.reset": "earliest",
    })
    consumer.subscribe([TOPICS_PATTERN])
    print(f"Subscribed to pattern: {TOPICS_PATTERN}", flush=True)
    print(f"Bootstrap servers: {BOOTSTRAP_SERVERS}", flush=True)

    try:
        while True:
            msg = consumer.poll(timeout=1.0)
            if msg is None:
                continue
            if msg.error():
                raise KafkaException(msg.error())

            if msg.value() is None:
                # tombstone (delete marker)
                print(f"[TOMBSTONE] {msg.topic()} | key={msg.key()}", flush=True)
                continue

            try:
                envelope = json.loads(msg.value())
            except (json.JSONDecodeError, TypeError):
                print(f"[UNPARSEABLE] {msg.topic()} | {msg.value()}", flush=True)
                continue

            payload = envelope.get("payload", envelope)
            handle_message(msg.topic(), payload)

    except KeyboardInterrupt:
        pass
    finally:
        consumer.close()


if __name__ == "__main__":
    main()
