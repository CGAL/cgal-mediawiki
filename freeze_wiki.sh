#!/bin/bash

LOCAL_SETTINGS="./LocalSettings.php"

if ! grep -q "\$wgReadOnly" $LOCAL_SETTINGS; then
    echo "\$wgReadOnly = 'The wiki is currently in read-only mode for maintenance. This wiki will be back in a few minutes.';" >> $LOCAL_SETTINGS
fi

echo "Wiki frozen successfully."