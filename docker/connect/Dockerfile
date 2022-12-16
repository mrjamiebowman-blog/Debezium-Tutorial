# This multi-stage build process starts off by creating 2 java keystores that will
# be used by the Debezium image. This is used for securiting the SSL with a self-signed
# certificate. This is not ideal for production but conceptualy demonestrates how this 
# could be set up.

#####################################################
#                     UBUNTU                        #
#####################################################

ARG UBUNTU_VERSION=23.04
FROM ubuntu:$UBUNTU_VERSION as ssl

# self-signed certificate
ARG KEYSTORE_PASSWORD=keystorepassword
ARG TRUSTSTORE_PASSWORD=truststorepassword
ARG KEY_PASSWORD=keypassword
ARG CA_PASSWORD=capassword

# directories
RUN mkdir -p /keystores
WORKDIR /keystores

# update and install tools
RUN apt-get update
RUN apt-get install -y openssl vim default-jre

# generate key store
RUN keytool -genkey -keystore keystore.jks -alias localhost -keyalg RSA -validity 365 -storepass ${KEYSTORE_PASSWORD} -keypass ${KEY_PASSWORD} --dname CN=localhost,OU=Blog,O=MrJamieBowman,ST=Missouri,L=St.Louis,C=US -ext SAN=DNS:localhost

# generate certificate authority (ca)
RUN openssl req -new -x509 -keyout ca-key -out ca-cert -days 365 -passout pass:${CA_PASSWORD} -subj "/C=US/ST=Missouri/L=St.Louis/D=Blog/OU=Dev/CN=localhost"

# import into keystore
RUN keytool -importcert -keystore truststore.jks -alias CaRoot -file ca-cert -noprompt -storepass ${KEYSTORE_PASSWORD}

# export the cert, sign it, restore it
RUN keytool -certreq -keystore keystore.jks -alias localhost -file cert-file -storepass ${KEYSTORE_PASSWORD}

# sign cert with ca
RUN openssl x509 -req -CA ca-cert -CAkey ca-key -in cert-file -out cert-signed -days 365 -CAcreateserial -passin pass:${CA_PASSWORD}

#  import
RUN keytool -importcert -keystore keystore.jks -alias CaRoot -file ca-cert -noprompt -storepass ${KEYSTORE_PASSWORD}
RUN keytool -importcert -keystore keystore.jks -alias localhost -file cert-signed -noprompt -storepass ${KEYSTORE_PASSWORD}

#####################################################
#                     DEBEZIUM                      #
#####################################################

ARG DEBEZIUM_VERSION=1.9
FROM debezium/connect:1.9
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

# keystores
RUN mkdir -p /keystores
COPY --from=ssl --chown=kafka:kafka /keystores/*.jks /keystores/

# history folder
RUN mkdir -p /kafka/connect/history/

# permissions
RUN chmod -R 644 /kafka/connect/debezium-connector-sqlserver/*.jar
RUN chown kafka:kafka -R /kafka/connect/debezium-connector-sqlserver/*.jar
RUN chown kafka:kafka -R /kafka/connect/history/

# set work directory
WORKDIR /kafka

# user: kafka
USER kafka