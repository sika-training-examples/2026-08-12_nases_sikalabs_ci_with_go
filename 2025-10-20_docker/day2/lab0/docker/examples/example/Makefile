up:
	docker compose up -d --remove-orphans

up-build:
	docker compose up -d --build --remove-orphans

down:
	docker compose down --remove-orphans

down-with-volumes:
	docker compose down --remove-orphans --volumes

use-caddy:
	echo 'COMPOSE_FILE=compose.base.yml:compose.scaled.yml:compose.caddy.yml' >> .env

use-traefik-internal:
	echo 'COMPOSE_FILE=compose.base.yml:compose.scaled.yml:compose.traefik-internal.yml' >> .env

use-traefik-external:
	echo 'COMPOSE_FILE=compose.base.yml:compose.scaled.yml:compose.traefik-external.yml' >> .env

use-ports:
	echo 'COMPOSE_FILE=compose.base.yml:compose.ports.yml' >> .env

use-tests:
	echo 'COMPOSE_FILE=compose.base.yml:compose.tests.yml' >> .env

run-test-ab:
	COMPOSE_FILE=compose.base.yml:compose.tests.yml docker compose run test-ab

run-test-curl:
	COMPOSE_FILE=compose.base.yml:compose.tests.yml docker compose run test-curl
