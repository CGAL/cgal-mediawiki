#!/bin/bash

cd /var/www/html

echo "Mediawiki update.php"
php maintenance/update.php --quick

if [ -z "$@" ]; then
  apache2-foreground
else
  bash -c "${@}"
fi
