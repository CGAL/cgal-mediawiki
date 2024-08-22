#!/bin/bash

OPERATION=freeze

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

LOCAL_SETTINGS=${1:-"./LocalSettings.php"}
if [ ! -f "$LOCAL_SETTINGS" ] && [ ! -c "$LOCAL_SETTINGS" ]; then
    echo "Error: File \"$LOCAL_SETTINGS\" not found."
    exit 1
fi
if [ ! -r "$LOCAL_SETTINGS" ] || [ ! -w "$LOCAL_SETTINGS" ]; then
    echo "Error: File \"$LOCAL_SETTINGS\" is not readable or writable."
    exit 1
fi

case $OPERATION in
freeze)
    echo "Freezing wiki..."
    if ! grep -q "\$wgReadOnly" "$LOCAL_SETTINGS"; then
        echo "\$wgReadOnly = 'The wiki is currently in read-only mode for maintenance. This wiki will be back in a few minutes.';" >> "$LOCAL_SETTINGS"
        echo "Wiki frozen successfully."
        exit 0
    else
        echo "Error: Wiki is already frozen."
        exit 1
    fi
    ;;
unfreeze)
    echo "Unfreezing wiki..."
    if grep -q "\$wgReadOnly" "$LOCAL_SETTINGS"; then
        sed -i '/\$wgReadOnly/d' "$LOCAL_SETTINGS"
        echo "Wiki unfrozen successfully."
        exit 0
    else
        echo "Error: Wiki is not frozen."
        exit 1
    fi
    ;;
esac
