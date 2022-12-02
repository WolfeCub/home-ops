#!/bin/bash

# Used to generate the daemonset in this folder. Should only need this if there's an update
# Sourcing the instructions from here https://kube-vip.io/docs/installation/daemonset/

VIP=192.168.0.220
INTERFACE=eno1
KVVERSION=$(curl -sL https://api.github.com/repos/kube-vip/kube-vip/releases | jq -r ".[0].name")

echo Found version $KVVERSION. Running....
sleep 2

docker run --network host --rm ghcr.io/kube-vip/kube-vip:$KVVERSION \
    manifest daemonset \
    --interface $INTERFACE \
    --address $VIP \
    --inCluster \
    --taint \
    --services \
    --arp \
    --leaderElection
