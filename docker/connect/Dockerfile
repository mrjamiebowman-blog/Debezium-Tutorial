FROM debezium/connect:latest
USER root
COPY plugins/ /kafka/connect/debezium-connector-sqlserver/
RUN chmod -R 644 /kafka/connect/debezium-connector-sqlserver/*.jar
RUN chown kafka:kafka -R /kafka/connect/debezium-connector-sqlserver/*.jar
USER kafka