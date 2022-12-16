

ARG DEBEZIUM_VERSION=1.9
FROM debezium/connect:$DEBEZIUM_VERSION
USER root

# copy plugins
COPY plugins/ /kafka/connect/debezium-connector-sqlserver/
RUN chmod -R 644 /kafka/connect/debezium-connector-sqlserver/*.jar
RUN chown kafka:kafka -R /kafka/connect/debezium-connector-sqlserver/*.jar

# basic authentication
WORKDIR /kafka/config
COPY connect.password .
COPY debezium_jaas.conf .
RUN chown kafka:kafka debezium_jaas.conf connect.password

# ssl
# COPY --from=ssl --chown=kafka:kafka /keystore/*.jks /keystore/

# set work directory
WORKDIR /kafka

USER kafka