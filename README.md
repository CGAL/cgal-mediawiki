## Setup and Installation

Clone the repository:

```
git clone https://github.com/SaillantNicolas/cgalmediawiki.git
cd cgalmediawiki
```

Build and start the Docker containers:

```
docker-compose up --build
```

Once the containers are up and running, import the MediaWiki database:

```
docker exec -i <DB_CONTAINER_NAME> mariadb -u <DB_USER> -p<DB_PASSWORD> <DB_NAME> < <Dump.sql>
```

Run the MediaWiki maintenance script to update the database:

```
docker exec -ti <MEDIAWIKI_CONTAINER_NAME> php /var/www/html/maintenance/update.php
```