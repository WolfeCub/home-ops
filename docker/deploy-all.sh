#!/bin/bash

if ! docker network inspect webnet > /dev/null; then
    docker network create -d overlay webnet --attachable
fi

for dir in auth admin passmanager smarthome blog torrent media; do
    cd $dir
    ./deploy.sh
    cd ..
done
