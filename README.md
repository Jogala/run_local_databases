# Good to know

Check processes running on specific port
``` 
sudo lsof -i :5432
```

You can termiante the process via

```
sudo kill 1198
```

Stop and remove container 

```
docker stop local-postgres && docker rm local-postgres
```


# # WORKING Container with persistent data

docker build -t custom_postgres  -f Dockerfile .
docker run --name local-postgres -d  --restart always -p 6543:5432 -v $path_local_data:/var/lib/postgresql/data custom_postgres


# WORKING Non persistent data 

stop local postgres database that might already use port 5432

```
sudo service postgresql stop
```

Then build and run the postgres image

```
docker run --name local-postgres -e POSTGRES_PASSWORD=password -d -p 6543:5432 postgres
docker exec -it local-postgres bash
```

In the container run
```
psql -h localhost -U postgres
```

to enter postgres and then create a database 

```
CREATE DATABASE name_of_database;
```


# adding to pg admin

You can add the database to your pg adminer via  the following details:
```
Host: 0.0.0.0  <-- 127.0.0.1 on windows
Port: 6543
Username: postgres
Password: password
```

Removing image if you need to change something...

```
docker stop local-postgres
docker rm local-postgres
```


# Example connect via knex

```
  development: {
    client: 'postgresql',
    connection: {
      host: '172.17.0.1',    <----- docker0 network ip adress, you get it via ifconfig or on windows eth0 ip address  
      port: '5432',
      database: 'test',
      user:     'postgres',
      password: 'password',
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },
``` 



