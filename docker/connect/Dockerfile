FROM debezium/connect:latest
USER root
COPY plugins/ /kafka/connect/
RUN cp /kafka/external_libs/debezium-scripting/debezium-scripting-2.0.0.Final.jar /kafka/conenct/
RUN chmod +R 644 /kafka/connect/*.jar
RUN chown kafka:kafka -R /kafka/connect/*.jar
USER kafka