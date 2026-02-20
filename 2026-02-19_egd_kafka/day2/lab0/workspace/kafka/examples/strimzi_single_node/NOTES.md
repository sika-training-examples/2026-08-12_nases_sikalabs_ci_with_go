```
# Add Kafka cluster to kaf config
kaf config add-cluster my-kafka-0 -b my-kafka-0-kafka-bootstrap.kafka.svc:9092

# Select the cluster
kaf config use-cluster my-kafka-0
```

kaf config add-cluster kafka -b kafka-kafka-bootstrap.kafka.svc:9092
kaf config use-cluster kafka