#!/bin/bash

shopt -s nullglob

exec chcon --recursive --type container_file_t composer.json db-init/ db-dumps/ images/ LocalSettings*.php caddy-data/ config update-context ./*.sh ./*.env
