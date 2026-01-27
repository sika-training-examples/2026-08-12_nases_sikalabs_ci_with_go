up:
	docker compose up -d --remove-orphans

down:
	docker compose down --remove-orphans

use-ports:
	echo COMPOSE_FILE=compose.yml:compose.ports.yml > .env

use-traefik:
	echo COMPOSE_FILE=compose.yml:compose.traefik.yml > .env
