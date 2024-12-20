#!/bin/bash
mariadb -u root -proot mediawiki < /docker-entrypoint-initdb.d/cgalwiki-dump.sql