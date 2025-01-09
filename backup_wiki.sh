#!/bin/bash

set -e

DB=$(docker ps --filter "name=db" --format "{{.Names}}")
WIKI_MEMBERS=$(docker ps --filter "name=mediawiki_members" --format "{{.Names}}")
WIKI_EDITORS=$(docker ps --filter "name=mediawiki_editors" --format "{{.Names}}")

# Check if DB and WIKI have a single word (non-empty) value
if [[ -z "$DB" || -z "$WIKI_MEMBERS" || -z "$WIKI_EDITORS" || $DB == *[[:space:]]* || $WIKI_MEMBERS == *[[:space:]]* || $WIKI_EDITORS == *[[:space:]]* ]]; then
    echo "Error: Cannot detect the container names. Candidates:"
    echo "         for 'db': $(echo $DB)"
    echo "  for 'mediawiki': $(echo $WIKI_MEMBERS)"
    echo "for 'mediawiki-editors': $(echo $WIKI_EDITORS)"
    exit 1
fi

if [ ! -d "./backup" ]; then
    mkdir ./backup
fi

bash freeze_wiki.sh ./LocalSettings-Members.php
bash freeze_wiki.sh ./LocalSettings-Editors.php
trap 'bash freeze_wiki.sh -u ./LocalSettings-Members.php; bash freeze_wiki.sh -u ./LocalSettings-Editors.php' EXIT

echo "Backing up wiki database..."
docker exec "$DB" mariadb-dump -u root -proot mediawiki >./backup/wiki_members_backup_$(date +%F).sql
docker exec "$DB" mariadb-dump -u root -proot mediawiki-editors >./backup/wiki_editors_backup_$(date +%F).sql

echo "Backing up wiki files..."
docker run --rm --volumes-from "$WIKI_MEMBERS:rw" -v $(pwd)/backup:/backup:z alpine tar -czf /backup/backup_wiki_files_$(date +%F).tar.gz -C /var/www/html/images .
docker run --rm --volumes-from "$WIKI_EDITORS:rw" -v $(pwd)/backup:/backup:z alpine tar -czf /backup/backup_wiki_editors_files_$(date +%F).tar.gz -C /var/www/html/images .

echo "Backup completed successfully."
