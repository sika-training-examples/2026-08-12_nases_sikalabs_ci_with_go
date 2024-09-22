default:
	@echo "See Makefile for options"

install-argocd:
	helm upgrade --install \
		argocd argo-cd \
		--repo https://argoproj.github.io/argo-helm \
		--create-namespace \
		--namespace argocd \
		--wait \
		--values ./_argocd/argocd.values.yml
