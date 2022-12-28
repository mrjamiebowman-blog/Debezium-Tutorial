#!/bin/bash

# auto-generate password
if ! [[ -s /kafka/config/connect.password ]]
then
    PASSWORD=$(cat /dev/urandom | tr -dc _A-Z-a-z-0-9 | head -c16)
    echo "debeziumuser: $PASSWORD" > /kafka/config/connect.password
    echo "[+] Created connect.password"
fi

# start
exec /docker-entrypoint.sh start