#!/bin/bash

OPERATION=freeze
wgReadOnlyFILE=./lock-mediawiki.txt

case "$1" in
-h | --help)
    echo "Usage: $0 [-u|--unfreeze] [LocalSettings.php]"
    echo "Freeze a MediaWiki instance by setting it to read-only mode."
    echo "If LocalSettings.php is not provided, it will default to ./LocalSettings.php."
    echo
    echo "Options:"
    echo "  -u, --unfreeze  Unfreeze the wiki by removing the read-only mode."
    echo "  -h, --help      Display this help message."
    exit 0
    ;;
-u | --unfreeze)
    OPERATION=unfreeze
    shift
    ;;
esac

case $OPERATION in
freeze)
    cat >"${wgReadOnlyFILE}" <<'EOF'
The wiki is currently in read-only mode for maintenance. This wiki will be back in a few minutes.
EOF
    ;;
unfreeze)
    cat </dev/null >"${wgReadOnlyFILE}"
    ;;
esac
