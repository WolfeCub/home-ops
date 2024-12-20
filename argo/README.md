# Argo Setup

Create age secret

```
cat ~/.config/sops/age/keys.txt |
    kubectl -n argocd create secret generic sops-age \
    --from-file=age.agekey=/dev/stdin
```

Bootstrap with helm

```
helm install argocd argo/argo-cd --values values.yaml --namespace argocd
```
