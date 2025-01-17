#!/bin/bash

set -e

DB=$(docker ps --filter "name=db" --format "{{.Names}}")
WIKI_MEMBERS=$(docker ps --filter "name=_mediawiki" --format "{{.Names}}")
WIKI_EDITORS=$(docker ps --filter "name=_wiki_editors" --format "{{.Names}}")

# Check if DB and WIKI have a single word (non-empty) value
if [[ -z "$DB" || -z "$WIKI_MEMBERS" || $DB == *[[:space:]]* || $WIKI_MEMBERS == *[[:space:]]* ]]; then
    echo "Error: Cannot detect the container names. Candidates:"
    echo "         for 'db': $(echo $DB)"
    echo "  for 'mediawiki': $(echo $WIKI_MEMBERS)"
    exit 1
fi

# Check if the EDITORS_WIKI variable is empty
if [[ -z "$WIKI_EDITORS" || $WIKI_EDITORS == *[[:space:]]* ]]; then
    echo "Error: Cannot detect the container name for 'mediawiki-editors'. Candidates:"
    echo "  for 'mediawiki-editors': $(echo $WIKI_EDITORS)"
    WIKI_EDITORS=
fi

if [ ! -d "./backup" ]; then
    mkdir ./backup
fi

freeze() {
    opt=$1
    bash freeze_wiki.sh $opt ./LocalSettings-Members.php
    [ -n "$WIKI_EDITORS" ] && bash freeze_wiki.sh $opt ./LocalSettings-Editors.php
    true
}

unfreeze() {
    freeze "-u"
}

freeze
trap unfreeze EXIT ERR

echo "Backing up wiki database..."
docker exec "$DB" mariadb-dump -u root -proot mediawiki >./backup/wiki_members_backup_.sql
[ -n "$WIKI_EDITORS" ] && docker exec "$DB" mariadb-dump -u root -proot mediawiki-editors >./backup/wiki_editors_backup_$(date +%F).sql

echo "Backing up wiki files..."
docker run --rm --volumes-from "$WIKI_MEMBERS:rw" -v $(pwd)/backup:/backup:z alpine tar -czf /backup/backup_wiki_files_$(date +%F).tar.gz -C /var/www/html/images .
[ -n "$WIKI_EDITORS" ] && docker run --rm --volumes-from "$WIKI_EDITORS:rw" -v $(pwd)/backup:/backup:z alpine tar -czf /backup/backup_wiki_editors_files_$(date +%F).tar.gz -C /var/www/html/images .

echo "Backup completed successfully."
