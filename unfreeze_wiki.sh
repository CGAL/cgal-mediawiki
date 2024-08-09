#!/bin/bash
LOCAL_SETTINGS="./LocalSettings.php"
sed -i '/\$wgReadOnly/d' $LOCAL_SETTINGS
docker-compose restart
echo "Wiki unfrozen successfully."