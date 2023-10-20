build:
	docker run \
		-w /build \
		-v $(shell pwd):/build \
		gcr.io/kaniko-project/executor:debug \
		--destination=ttl.sh/kaniko-example \
		--cache=true \
		--cache-dir=/build/.kaniko-cache

run:
	docker run -p 8000:8000 ttl.sh/kaniko-example
