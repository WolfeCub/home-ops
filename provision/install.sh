#!/bin/bash

sudo mkdir -p /etc/rancher/k3s/

echo '
kubelet-arg:
  - "feature-gates=GracefulNodeShutdown=true"
  - "feature-gates=MixedProtocolLBService=true"
# Required to use monitor these components with kube-prometheus-stack
kube-controller-manager-arg:
  - "address=0.0.0.0"
  - "bind-address=0.0.0.0"
kube-proxy-arg:
  - "metrics-bind-address=0.0.0.0"
kube-scheduler-arg:
  - "address=0.0.0.0"
  - "bind-address=0.0.0.0"
etcd-expose-metrics: true
# Required for HAProxy health-checks
kube-apiserver-arg:
  - "anonymous-auth=true"
' | sudo tee /etc/rancher/k3s/config.yaml

read -p "Is this the first node? [Y/n]" -n 1 -r
echo ""

if [[ -z ${K3S_TOKEN} ]]; then
  echo -n "k3s Token: "
  read K3S_READ_TOKEN
fi

if [[ "$REPLY" =~ ^[Yy]$ ]]; then
  echo "Installing with cluster init" 
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik --cluster-init" K3S_TOKEN="$K3S_READ_TOKEN" sh -
else
  curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik" K3S_TOKEN="$K3S_READ_TOKEN" sh -s - server --server "https://192.168.0.250:6443"
fi

if [[ "$REPLY" =~ ^[Nn]$ ]]; then
  exit
fi

if [[ -z ${GITHUB_TOKEN} ]]; then
  echo -n "Github PAT: "
  read GITHUB_TOKEN
fi

flux bootstrap github --owner=Mulan-Szechuan-Sauce --repository=house20-admin --path=kubernetes/bootstrap --branch=master

if [[ -z ${KEY_FP} ]]; then
  echo -n "GPG Key Fingerprint"
  read KEY_FP
fi

gpg --export-secret-keys --armor "${KEY_FP}" | kubectl create secret generic sops-gpg --namespace=flux-system --from-file=sops.asc=/dev/stdin
