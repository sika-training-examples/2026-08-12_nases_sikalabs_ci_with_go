# pss-argocd-apps

## Install ArgoCD

```bash
helm upgrade --install \
	argocd argo-cd \
	--repo https://argoproj.github.io/argo-helm \
	--create-namespace \
	--namespace argocd \
	--wait
```

## First Apply of ArgoCD App of Apps

```bash
kubectl apply -f clusters/pss
```

## Vault Init

```bash
kubectl exec -ti -n vault vault-0 -- vault operator init -format=json > vault_init.local.json
```

## Vault Unseal (from vault_init.local.json file)

```bash
kubectl exec -ti -n vault vault-0 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[0]')
kubectl exec -ti -n vault vault-0 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[1]')
kubectl exec -ti -n vault vault-0 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[2]')

kubectl exec -ti -n vault vault-1 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[0]')
kubectl exec -ti -n vault vault-1 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[1]')
kubectl exec -ti -n vault vault-1 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[2]')

kubectl exec -ti -n vault vault-2 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[0]')
kubectl exec -ti -n vault vault-2 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[1]')
kubectl exec -ti -n vault vault-2 -- vault operator unseal $(cat vault_init.local.json | jq -r '.unseal_keys_b64[2]')
```
