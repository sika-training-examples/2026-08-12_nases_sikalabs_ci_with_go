FROM quay.io/strimzi/kafka:1.0.1-kafka-4.1.1

USER root:root

RUN mkdir -p /opt/kafka/plugins/debezium-connector-postgres && \
    curl -sL https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/3.1.2.Final/debezium-connector-postgres-3.1.2.Final-plugin.tar.gz \
    | tar -xz -C /opt/kafka/plugins/debezium-connector-postgres --strip-components=1

RUN mkdir -p /opt/kafka/plugins/debezium-connector-mongodb && \
    curl -sL https://repo1.maven.org/maven2/io/debezium/debezium-connector-mongodb/3.1.2.Final/debezium-connector-mongodb-3.1.2.Final-plugin.tar.gz \
    | tar -xz -C /opt/kafka/plugins/debezium-connector-mongodb --strip-components=1

USER 1001
