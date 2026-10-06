IMAGE = ondrejsika/probes-example-server

all: build push

build:
	docker build --platform linux/amd64 -t $(IMAGE) .

push:
	docker push $(IMAGE)
