#!/bin/bash

sed -i 's/#//g' docker-compose.yml

composer install
composer update

docker build -t my-mediawiki .

#cat AddLocalSettings.txt >> LocalSettings.php

sed -i 's/mediawiki:lts/my-mediawiki/g' docker-compose.yml

docker-compose up -d

container_name=$(docker ps -a | grep "mediawiki-1$" | awk '{print $NF}')
docker exec -ti $container_name php /var/www/html/maintenance/update.php
