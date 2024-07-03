#!/bin/sh

BRANCH="REL1_39"
REPO_BASE="https://gerrit.wikimedia.org/r/mediawiki/extensions"
EXTENSIONS="VisualEditor PageForms ConfirmAccount Interwiki Renameuser UserMerge MagicNoCache Math ParserFunctions SyntaxHighlight_GeSHi UrlGetParameters DiscussionThreading"

cd /var/www/html

composer install
composer update --no-dev

mkdir -p extensions

cd extensions

for EXTENSION in $EXTENSIONS; do
    if [ -d "$EXTENSION" ]; then
        rm -rf "$EXTENSION"
    fi
done

for EXTENSION in $EXTENSIONS; do
    git clone -b "$BRANCH" "$REPO_BASE/$EXTENSION"
done

apache2-foreground
