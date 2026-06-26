```
# Add Kafka cluster to kaf config
kaf config add-cluster my-cluster -b my-cluster-kafka-bootstrap.kafka.svc:9092

# Select the cluster
kaf config use-cluster my-cluster
```
