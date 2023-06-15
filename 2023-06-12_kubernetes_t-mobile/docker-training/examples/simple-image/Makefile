build-debian:
	docker build -t simple-image -f Dockerfile.debian . --platform linux/arm64

build:
	docker build -t simple-image .

run:
	docker run -p 8000:80 simple-image
