#!/bin/bash

# Parse command-line options
# Option strings
SHORT=r
LONG=rebuild
# read the options
OPTS=$(getopt --options $SHORT --long $LONG --name "$0" -- "$@")
if [ $? != 0 ] ; then echo "Failed to parse options...exiting." >&2 ; exit 1 ; fi
eval set -- "$OPTS"
# set initial values
REBUILD=false
# extract options and their arguments into variables.
while true ; do
  case "$1" in
    -r | --rebuild )
      REBUILD=true
      shift
      ;;
    -- )
      shift
      break
      ;;
    *)
      echo "Internal error!"
      exit 1
      ;;
  esac
done
# Print the variables
echo "REBUILD = $REBUILD"
echo "FILE = $FILE"

local_path_data_postgres=$HOME"/data_local_databases/postgres"
local_path_data_mysql=$HOME"/data_local_databases/mysql"
mkdir -p $local_path_data_postgres
mkdir -p $local_path_data_mysql

if $REBUILD; then 
    echo "rebuild!!!"
    docker container stop local-postgres && docker container rm local-postgres
    docker container stop local-mysql && docker container rm local-mysql
fi

cd postgres
docker build -t custom_postgres  -f Dockerfile .
docker run --name local-postgres -d  --restart always -p 5432:5432 -v $local_path_data_postgres:/var/lib/postgresql/data custom_postgres
cd -

cd mysql
docker build -t custom_mysql  -f Dockerfile .
docker run --name local-mysql -d --restart always -p 3306:3306 -v $local_path_data_mysql:/var/lib/mysql custom_mysql
cd -


