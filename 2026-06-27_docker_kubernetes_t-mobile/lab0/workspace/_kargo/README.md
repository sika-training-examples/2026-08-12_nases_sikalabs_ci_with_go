[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# kcd2026-kargo-workshop

- https://sika.link/kcd2026-kargo
- https://large-type.com/#sika.link%2Fkcd2026-kargo

Repository we've created during workshop

<https://github.com/ondrejsika/kcd2026-kargo-example>

## Goal of the Workshop

- Deploy example app in multiple environments: dev, staging, prod
- Implement promotion of new changes (images, config) accross the stages
- Do it using GitOps

## What is ArgoCD?

[ArgoCD](https://argo-cd.readthedocs.io) is an open-source declarative, GitOps continuous delivery tool for Kubernetes. It continuously syncs the desired state defined in a Git repository with the actual state of a Kubernetes cluster, automatically detecting and correcting drift.

- <https://argoproj.github.io/cd>
- <https://github.com/argoproj/argo-cd>
- <https://argo-cd.readthedocs.io>

## What is Kargo?

[Kargo](https://kargo.io) is an open-source continuous promotion framework for Kubernetes, built by Akuity. It models your software delivery pipeline as a sequence of **Stages** (e.g. dev → staging → production), each pinned to specific artifact versions called **Freights**. Kargo tracks where each Freight is, automates its promotion through the pipeline, and enforces approval gates — giving teams safe, auditable, GitOps-native progressive delivery without hand-rolled shell scripts.

Kargo a common companion to ArgoCD — Kargo decides *what* to promote and *when*, while ArgoCD handles the actual deployment to the cluster.

- <https://kargo.io>
- <https://github.com/akuity/kargo>
- <https://docs.kargo.io/>

## Create Repo

Create repo `github.com/ondrejsika/kcd2026-kargo-example`

## Deploy cluster essentials using ArgoCD

Copy `clusters/kcd/{_app_of_apps,_cluster}` them from `example/`

Commit and push

## Install ArgoCD

```
helm upgrade --install \
  argocd argo-cd \
  --repo https://argoproj.github.io/argo-helm \
  --create-namespace \
  --namespace argocd \
  --wait
```

## Apply app-of-apps

```
kubectl apply -f clusters/kcd/_app_of_apps
```

## Checkout ArgoCD and Kargo

- https://argocd.kcd.sikademo.com
- https://kargo.kcd.sikademo.com

Username `admin`, password `admin` for both.

## Add ArgoCD Webbook to Github

`https://argocd.kcd.sikademo.com/api/webhook`

## Build and push hello image

Copy `clusters/src/hello` from `example/`

Commit

```
make -C ./src/hello build-and-push
```

## Create ArgoCD Apps for hello app

Copy `clusters/kcd/hello/{argocd,values}` from `example/`

Commit and push

See:

- https://argocd.kcd.sikademo.com
- https://hello-dev.kcd.sikademo.com
- https://hello-staging.kcd.sikademo.com
- https://hello-prod.kcd.sikademo.com

## Create Kargo config for hello app

Copy `clusters/kcd/hello/kargo` from `example/`

Commit and push


## Kargo Components

<https://docs.kargo.io/user-guide/core-concepts>

### Project

Top-level namespace that groups all Kargo resources for a single application or team.

### Warehouse

Watches artifact sources (container registries, Helm chart repos, Git repos) and packages new versions as Freight.

### Freight

An immutable, versioned bundle of artifact references (image tag, chart version, Git commit) ready to be promoted.

### Stage

A deployment target (e.g. dev, staging, prod) that tracks which Freight is current and defines promotion criteria.

### Promotion

A record of moving a specific Freight into a Stage; Kargo creates one automatically or on manual approval.

### Promotion Steps

https://docs.kargo.io/user-guide/reference-docs/promotion-steps

## Try Image Update

Build and push image v2

```
make -C ./src/hello build-and-push BUILD_ID=2
```

See Kargo and apps:

- https://kargo.kcd.sikademo.com
- https://hello-dev.kcd.sikademo.com
- https://hello-staging.kcd.sikademo.com
- https://hello-prod.kcd.sikademo.com

## Try Update Values

```
vim clusters/kcd/hello/values/dev/common.values.yaml
```

Commit and push.

See Kargo and apps

## Another example - counter (be + fe)

Based on:

- https://github.com/ondrejsika/counter (backend)
- https://github.com/ondrejsika/counter-frontend-go

Build images

```
make -C ./src/backend build-and-push
make -C ./src/frontend build-and-push
```

Copy `src/{backend,fronted}` and `clusters/kcd/counter` from `example/`

Commit and push

See:

- https://kargo.kcd.sikademo.com
- https://counter-dev.kcd.sikademo.com
- https://counter-staging.kcd.sikademo.com
- https://counter-prod.kcd.sikademo.com

And try build new images or update values

```
make -C ./src/backend build-and-push BUILD_ID=2
make -C ./src/frontend build-and-push BUILD_ID=2
```
