#!/bin/bash

LOCAL_SETTINGS="./LocalSettings.php"

if [ ! -d "./backup" ]; then
    mkdir ./backup
fi

if ! grep -q "\$wgReadOnly" $LOCAL_SETTINGS; then
    echo "\$wgReadOnly = 'The wiki is currently in read-only mode for maintenance. This wiki will be back in a few minutes.';" >> $LOCAL_SETTINGS
fi

docker exec $(docker ps --filter "name=db" --format "{{.Names}}") mariadb-dump -u root -proot mediawiki > ./backup/backup_$(date +%F).sql

# TODO Podman

tar -czvf ./backup/backup_wiki_files_$(date +%F).tar.gz ./images

echo "Wiki frozen and backups created successfully."