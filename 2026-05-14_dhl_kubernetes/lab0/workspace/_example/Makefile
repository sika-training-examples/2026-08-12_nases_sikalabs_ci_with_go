up:
	docker compose up -d --remove-orphans

up-build:
	docker compose up -d --build --remove-orphans

down:
	docker compose down --remove-orphans

down-with-volumes:
	docker compose down --remove-orphans --volumes

build:
	docker compose build

push:
	docker compose push

helm-install:
	helm upgrade --install dhl-example ./kubernetes/chart -f ./kubernetes/values/local.values.yaml

helm-template:
	helm template dhl-example ./kubernetes/chart -f ./kubernetes/values/local.values.yaml

helm-package-and-push:
	helm package kubernetes/chart
	helm push dhl-example-0.0.0.tgz oci://ttl.sh/helm
