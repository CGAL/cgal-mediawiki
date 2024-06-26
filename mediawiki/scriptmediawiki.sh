#!/bin/bash

# décommenter les lignes commenter
sed -i 's/#//g' docker-compose.yml

# installation des dépendances composer
composer install
composer update

# construction de l'image docker
docker build -t my-mediawiki .

# Ajout du contenue de AjoutLocalSettings a LocalSettings
#cat AddLocalSettings.txt >> LocalSettings.php

# change l'image du docker-compose
sed -i 's/mediawiki:1.35/my-mediawiki/g' docker-compose.yml

# Lancement des containers
docker-compose up -d

container_name=$(docker ps -a | grep "mediawiki-1$" | awk '{print $NF}')
docker exec -ti $container_name php /var/www/html/maintenance/update.php
