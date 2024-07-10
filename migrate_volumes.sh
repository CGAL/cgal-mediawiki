#!/bin/bash

volumes=("cgalmediawiki_db-data" "cgalmediawiki_caddy-data")

backup_dir="./docker_volume_backups"
mkdir -p $backup_dir

#export_docker_volume() {
#    volume=$1
#    echo "Exporting Docker volume: $volume"
#    docker run --rm -v $volume:/data -v $backup_dir:/backup alpine tar cvf /backup/${volume}.tar -C /data .
#}
export_docker_volume() {
    volume=$1
    echo "Exporting Docker volume: $volume"
    temp_container=$(docker create -v $volume:/data alpine:latest /bin/sh -c "tar cf /tmp/backup.tar -C /data .")
    docker start $temp_container
    docker wait $temp_container
    docker cp $temp_container:/tmp/backup.tar $backup_dir/${volume}.tar
    docker rm $temp_container
}

import_podman_volume() {
    volume=$1
    echo "Importing volume to Podman: $volume"
    podman volume create $volume
    podman run --rm -v $volume:/data:Z -v $backup_dir:/backup:ro,Z alpine:latest /bin/sh -c "cd /data && tar xvf /backup/${volume}.tar"

}


for volume in "${volumes[@]}"; do
    export_docker_volume $volume
done

for volume in "${volumes[@]}"; do
    import_podman_volume $volume
done

echo "Cleaning up temporary files"
rm -rf $backup_dir

echo "Complete!"
