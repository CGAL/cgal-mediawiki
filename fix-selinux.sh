#!/bin/bash

shopt -s nullglob

exec chcon -v -R --type container_file_t db-init* db-data* images*/ LocalSettings.php caddy-data* config update-context *.sh
