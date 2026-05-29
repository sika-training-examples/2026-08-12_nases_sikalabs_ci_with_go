# fluxcd-training

## Course

## Install Flux using Helm

```
helm install -n flux-system --create-namespace flux oci://ghcr.io/fluxcd-community/charts/flux2
```

## Install the Flux CLI

- https://fluxcd.io/flux/installation/#install-the-flux-cli

Mac

```bash
brew install fluxcd/tap/flux
```

or upgrade

```bash
brew upgrade fluxcd/tap/flux
```

Linux

```bash
curl -s https://fluxcd.io/install.sh | sudo bash
```

Autocomplete

```bash
. <(flux completion bash)
```

ZSH

```zsh
. <(flux completion zsh)
```

## Bootstrap using Gitlab

- https://fluxcd.io/flux/installation/bootstrap/gitlab/
- https://gitlab.sikademo.com/-/user_settings/personal_access_tokens

Create in group

```bash
export GITLAB_TOKEN=
GITLAB_HOSTNAME=gitlab.sikademo.com
GITLAB_OWNER=ondrejsika
GITLAB_REPOSIOTRY=example
GITLAB_PROJECT_PATH=clusters/sikademo
```

```bash
flux bootstrap gitlab \
  --deploy-token-auth \
  --owner=$GITLAB_OWNER \
  --repository=$GITLAB_REPOSIOTRY \
  --branch=master \
  --hostname=$GITLAB_HOSTNAME \
  --path=$GITLAB_PROJECT_PATH
```

or personal

```bash
export GITLAB_TOKEN=
GITLAB_HOSTNAME=gitlab.sikademo.com
GITLAB_OWNER=ondrejsika
GITLAB_REPOSIOTRY=example
GITLAB_PROJECT_PATH=clusters/sikademo
```

```bash
flux bootstrap gitlab \
  --deploy-token-auth \
  --owner=$GITLAB_OWNER \
  --repository=$GITLAB_REPOSIOTRY \
  --branch=master \
  --hostname=$GITLAB_HOSTNAME \
  --path=$GITLAB_PROJECT_PATH \
  --personal # required for personal project
```

## Git Repository

```yaml
apiVersion: source.toolkit.fluxcd.io/v1
kind: GitRepository
metadata:
  name: fluxcd-training
  namespace: flux-system
spec:
  url: https://github.com/ondrejsika/fluxcd-training.git
  timeout: 60s
  interval: 1m0s
  ref:
    branch: master
```

```
kubectl get GitRepository -A
```

## Kustomization

```yaml
apiVersion: kustomize.toolkit.fluxcd.io/v1
kind: Kustomization
metadata:
  name: kustomize01
  namespace: flux-system
spec:
  sourceRef:
    kind: GitRepository
    name: fluxcd-training
  path: ./examples/kustomize01/
  interval: 1m0s
  prune: true
  force: false
```

```
kubectl get Kustomization -A
```

## Helm Repoisotry

```yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: sikalabs
  namespace: flux-system
spec:
  url: https://helm.sikalabs.io
  interval: 1m
```

```
kubectl get HelmRepository -A
```

## Helm Repoisotry from Artifactory

```yaml
apiVersion: source.toolkit.fluxcd.io/v1beta2
kind: HelmRepository
metadata:
  name: artifactory
  namespace: flux-system
spec:
  url: https://artifactory.sikademo.com/artifactory/api/helm/hello-world-helm
  interval: 1m
  secretRef:
    name: artifactory-credentials
---
apiVersion: v1
kind: Secret
metadata:
  name: artifactory-credentials
  namespace: flux-system
type: Opaque
stringData:
  username: admin
  password: cmVmdGtuOjAxOjE3NjQ3MDc4Mjk6dFZKWXpZeEN4VTM0Rm9CWVNqQ2tBMjI4Y2RO
```

## Helm Release

```yaml
apiVersion: helm.toolkit.fluxcd.io/v2beta1
kind: HelmRelease
metadata:
  name: hello-world
  namespace: default
spec:
  releaseName: hello-world
  chart:
    spec:
      chart: hello-world
      sourceRef:
        kind: HelmRepository
        name: sikalabs
        namespace: flux-system
      version: 0.10.0
  interval: 1m
  values:
    host: hello-world.k8s.sikademo.com
    replicas: 2
```

```
kubectl get HelmRelease -A
```

## FluxCD UI - Capacitor

```bash
kubectl apply -f ./examples/capacitor.yml
```

Expose it

```bash
kubectl -n flux-system port-forward svc/capacitor 9000:9000
```

See it: http://127.0.0.1:9000

## Hello World example using Kustomization

```bash
kubectl apply -f ./examples/kustomization02.yml
```

## Counter example on k3d

Setup k3d cluster

```
k3d cluster create
```

Install Flux (using Helm)

```
helm install -n flux-system --create-namespace flux oci://ghcr.io/fluxcd-community/charts/flux2
```

Install counter example

```
kubectl apply -f ./examples/counter.yml
```

Port forward to frontend

```
kubectl port-forward -n counter svc/frontend 8000:80
```

See it

http://127.0.0.1:8000

## Training Sessions

### 2025-01-14 T-Mobile

FluxCD Repositories

- https://github.com/sika-training-examples/2025-01-14_ondrejsika-gitops
- https://github.com/sika-training-examples/2025-01-14_ondrejsika-gitops-example
- https://github.com/sika-training-examples/2025-01-14_gitops-tenants
- https://github.com/sika-training-examples/2025-01-14_example-counter-gitops

Helm Chart Repositories

- https://github.com/sika-training-examples/2025-01-14_example-counter-backend-helm
- https://github.com/sika-training-examples/2025-01-14_example-counter-frontend-helm

Application Repositories (with Dockerfiles)

- https://github.com/sika-training-examples/2025-01-14_example-counter-backend
- https://github.com/sika-training-examples/2025-01-14_example-counter-frontend

### 2024-12-02 T-Mobile

- https://github.com/sika-training-examples/2024-12-02_fluxcd-example
- https://github.com/sika-training-examples/2024-12-03_t-mobile-fluxcd-example
