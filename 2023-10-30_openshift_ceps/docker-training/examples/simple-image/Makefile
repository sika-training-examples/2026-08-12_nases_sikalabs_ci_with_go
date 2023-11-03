build-debian:
	docker build -t ttl.sh/simple-image -f Dockerfile.debian . --platform linux/amd64

build:
	docker build -t ttl.sh/simple-image . --platform linux/amd64

run:
	docker run -p 80:80 simple-image
