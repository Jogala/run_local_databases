#!/bin/bash
local_path_data="~/data_postgres"
mkdir -p $local_path_data

docker build -t custom_postgres  -f Dockerfile .
docker run --name local-postgres -d  --restart always -p 6543:5432 -v $local_path_data:/var/lib/postgresql/data custom_postgres
