#!/bin/bash

if ! docker network inspect webnet > /dev/null; then
    docker network create -d overlay webnet --attachable
fi

for dir in admin registry vpn media school; do
    cd $dir
    ./deploy.sh
    cd ..
done
