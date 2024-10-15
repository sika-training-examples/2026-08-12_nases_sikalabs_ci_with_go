VERSION = v2
IMAGE = ondrejsika/counter-with-text

build-and-push:
	docker build --platform linux/amd64 -t $(IMAGE):$(VERSION) .
	docker push $(IMAGE):$(VERSION)
