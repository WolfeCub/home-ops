#!/bin/bash

if ! docker network inspect webnet > /dev/null; then
    docker network create -d overlay webnet --attachable
fi

for dir in media registry vpn; do
    $dir/deploy.sh
done
