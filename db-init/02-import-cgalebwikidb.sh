#!/bin/bash
mariadb -u root -proot "mediawiki-editors" < /docker-entrypoint-initdb.d/cgalebwikidb.sql
