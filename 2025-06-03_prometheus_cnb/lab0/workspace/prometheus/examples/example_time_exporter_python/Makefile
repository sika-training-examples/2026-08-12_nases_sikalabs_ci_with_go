IMAGE = ttl.sh/example-time-exporter-python

all: build push

build:
	docker build --platform linux/amd64 -t ${IMAGE} .

push:
	docker push ${IMAGE}

run :
	docker run -p 10002:8000 -d ${IMAGE}
