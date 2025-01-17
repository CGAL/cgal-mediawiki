#!/bin/bash

[ -f /db-dumps/cgalebwikidb.sql ] || exit 0;

mariadb -u root -proot "mediawiki-editors" < /db-dumps/cgalebwikidb.sql
