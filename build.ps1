clear

# build mssql docker image
docker build --no-cache -f ./docker/mssql/Dockerfile -t mrjb/debezium-mssql docker/mssql