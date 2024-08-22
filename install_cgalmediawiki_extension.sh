#!/bin/bash

BRANCH="REL${MW_VERSION/./_}"
echo "Mediawiki version is $MW_VERSION (branch $BRANCH)"
REPO_BASE="https://gerrit.wikimedia.org/r/mediawiki/extensions"
EXTENSIONS="VisualEditor PageForms ConfirmAccount Interwiki Renameuser UserMerge MagicNoCache Math ParserFunctions SyntaxHighlight_GeSHi UrlGetParameters DiscussionThreading DismissableSiteNotice"

pushd /var/www/html

mkdir -p extensions

pushd extensions

for EXTENSION in $EXTENSIONS; do
    if [ -d "$EXTENSION" ]; then
        rm -rf "$EXTENSION"
    fi
done

for EXTENSION in $EXTENSIONS; do
    git clone --depth 1 --recurse-submodules --shallow-submodules -b "$BRANCH" "$REPO_BASE/$EXTENSION"
done

popd
