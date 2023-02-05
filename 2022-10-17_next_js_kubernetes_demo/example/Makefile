IMAGE_NAME = registry.sikalabs.com/demo/devx-example:local

all: docker-build docker-push

fmt:
	yarn run fmt

docker-build:
	docker build -t $(IMAGE_NAME) .

docker-push:
	docker push $(IMAGE_NAME)
