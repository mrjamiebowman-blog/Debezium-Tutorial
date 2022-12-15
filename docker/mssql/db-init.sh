#!/bin/bash

# sleep for 25s for sql server to come up
sleep 25s

# run database setup script
echo "[+] Running SQL Setup Script"

# run sqlcmd
/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P RqrhWH5HmwGc6mEF -d master -i /mssql/db.sql