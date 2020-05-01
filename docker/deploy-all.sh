#!/bin/bash

if ! docker network inspect vmnet > /dev/null; then
    docker network create -d overlay vmnet --attachable
fi

for dir in admin storage iot webapps; do
    cd $dir
    ./deploy.sh
    cd ..
done
