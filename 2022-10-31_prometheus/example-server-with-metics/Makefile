IMAGE_NAME = ondrejsika/example-server-with-metrics-2022-11-01

build-push: build push

build:
	docker build --platform linux/amd64 -t $(IMAGE_NAME) .

push:
	docker push $(IMAGE_NAME)
