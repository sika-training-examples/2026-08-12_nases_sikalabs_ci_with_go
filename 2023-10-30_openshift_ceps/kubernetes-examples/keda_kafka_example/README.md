# Keda Kafka Example

```
kaf config  add-cluster kafka --brokers kafka-kafka-bootstrap.kafka.svc:9092
kaf config use-cluster kafka
```

```
watch -n 0.3 kaf group describe default
```
