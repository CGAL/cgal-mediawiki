#!/bin/bash

if [ ! -d "./backup" ]; then
    mkdir ./backup
fi

bash freeze_wiki.sh

docker exec $(docker ps --filter "name=db" --format "{{.Names}}") mariadb-dump -u root -proot mediawiki > ./backup/wiki_backup_$(date +%F).sql

tar -czvf ./backup/backup_wiki_files_$(date +%F).tar.gz ./images

bash unfreeze_wiki.sh

echo "Wiki backup successfully."