#!/bin/sh

helm upgrade --install \
        argocd argo-cd \
        --repo https://argoproj.github.io/argo-helm \
        --create-namespace \
        --namespace argocd \
        --set 'configs.cm.url'=https://argocd.k8s.sikademo.com \
        --set 'configs.params.server\.insecure=true' \
        --set 'server.ingress.enabled=true' \
        --set 'server.ingress.hostname='argocd.k8s.sikademo.com \
        --set 'server.ingress.ingressClassName=traefik' \
        --set 'server.ingress.annotations.cert-manager\.io/cluster-issuer=letsencrypt' \
        --set 'server.ingress.tls=true' \
        --wait