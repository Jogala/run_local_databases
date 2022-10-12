#!/bin/bash
local_path_data_postgres=$HOME"/data_local_databases/postgres"
local_path_data_mysql=$HOME"/data_local_databases/mysql"
mkdir -p $local_path_data_postgres
mkdir -p $local_path_data_mysql

cd postgres
docker build -t custom_postgres  -f Dockerfile .
docker run --name local-postgres -d  --restart always -p 6543:5432 -v $local_path_data_postgres:/var/lib/postgresql/data custom_postgres
cd -

cd mysql
docker build -t custom_mysql  -f Dockerfile .
docker run --name local-mysql -d --restart always -p 8087:8080 -v $local_path_data_mysql:/var/lib/mysql custom_mysql
cd -


