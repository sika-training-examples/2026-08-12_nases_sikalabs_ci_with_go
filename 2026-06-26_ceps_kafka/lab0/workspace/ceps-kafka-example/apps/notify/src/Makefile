-include .env
export

IMAGE=ttl.sh/ceps/notify:v2

run:
	uv run python main.py

docker-build-and-push:
	docker build . -t ${IMAGE}
	docker push ${IMAGE}

install-uv:
	curl -LsSf https://astral.sh/uv/install.sh | sh
