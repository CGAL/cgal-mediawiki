#!/bin/bash

[ -f /db-dumps/cgalwiki-dump.sql ] || exit 0;

mariadb -u root -proot mediawiki < /db-dumps/cgalwiki-dump.sql