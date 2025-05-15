#!/bin/bash

BRANCH="REL${MW_VERSION/./_}"
echo "Mediawiki version is $MW_VERSION (branch $BRANCH)"
REPO_BASE="https://gerrit.wikimedia.org/r/mediawiki/extensions"
EXTENSIONS="VisualEditor ConfirmAccount Interwiki Renameuser UserMerge MagicNoCache Math ParserFunctions SyntaxHighlight_GeSHi UrlGetParameters DiscussionThreading DismissableSiteNotice"

WIKIMARKDOWN_REPO="https://github.com/lrineau/WikiMarkdown"
WIKIMARKDOWN_BRANCH=fix-for-mw1.42
PARSEDOWN_EXTENDED_REPO="https://github.com/BenjaminHoegh/ParsedownExtended"

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

if [ -d "WikiMarkdown" ]; then
    rm -rf "WikiMarkdown"
fi

git clone --depth 1 -b "$WIKIMARKDOWN_BRANCH" "$WIKIMARKDOWN_REPO" WikiMarkdown

if [ -d "WikiMarkdown/vendor/parsedown-extended" ]; then
    rm -rf "WikiMarkdown/vendor/parsedown-extended"
fi

git clone --depth 1 "$REPO_BASE/PageForms" PageForms

mkdir -p WikiMarkdown/vendor/parsedown-extended
git clone --depth 1 "$PARSEDOWN_EXTENDED_REPO" WikiMarkdown/vendor/parsedown-extended

popd
