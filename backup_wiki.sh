#!/bin/bash

set -e

DB=$(docker ps --filter "name=_db" --format "{{.Names}}")
WIKI=$(docker ps --filter "name=_mediawiki" --format "{{.Names}}")

# Check if DB and WIKI have a single word (non-empty) value
if [[ -z "$DB" || -z "$WIKI" || $DB == *[[:space:]]* || $WIKI == *[[:space:]]* ]]; then
    echo "Error: Cannot detect the container names. Candidates:"
    echo "         for 'db': $(echo $DB)"
    echo "  for 'mediawiki': $(echo $WIKI)"
    exit 1
fi

if [ ! -d "./backup" ]; then
    mkdir ./backup
fi

bash -$- freeze_wiki.sh
trap 'bash -$- unfreeze_wiki.sh' EXIT

echo "Backing up wiki database..."
docker exec "$DB" mariadb-dump -u root -proot mediawiki >./backup/wiki_backup_$(date +%F).sql

echo "Backing up wiki files..."
docker run --rm --volumes-from "$WIKI:rw" -v $(pwd)/backup:/backup:z alpine tar -czf /backup/backup_wiki_files_$(date +%F).tar.gz -C /var/www/html/images .

echo "Backup completed successfully."
