## Setup and Installation

Clone the repository:

```
git clone https://github.com/SaillantNicolas/cgalmediawiki.git
cd cgalmediawiki
```

Copy a dump of the database in `db-init/`.

Then build and start the Docker containers:

If the dump of the database is from a Mediawiki version older than 1.31, you need to update the database schema:
```
docker-compose --profile update up --build
docker-compose down
```

Otherwise, you can start the containers directly:
```
docker-compose up -d
```
