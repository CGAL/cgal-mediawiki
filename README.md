# Setup and Installation

Clone the repository:

```shell
git clone https://github.com/SaillantNicolas/cgalmediawiki.git
cd cgalmediawiki
```

Copy a dump of the database in `db-init/`.

Then build and start the Docker containers:

If the dump of the database is from a Mediawiki version older than 1.31, you need to update the database schema:

```shell
docker-compose run update_db
```

Otherwise, you can start the containers directly:

```shell
docker-compose --profile test up
```

or:

```shell
docker-compose --profile production up -d
```

# To run directly into podman

## system podman

Start the `podman.socket` unit with `systemctl`.

Then:

```shell
export DOCKER_HOST=unix:///run/podman/podman.sock
export CONTAINER_HOST=unix:///run/podman/podman.sock
```

or:

```shell
source ./system-podman.env
```

## rootless podman

Or, using the rootless user podman:

```shell
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
export CONTAINER_HOST=unix://$XDG_RUNTIME_DIR/podman/podman.sock
```
or:

```shell
source ./user-podman.env
```

Then, you can run the commands as usual.
