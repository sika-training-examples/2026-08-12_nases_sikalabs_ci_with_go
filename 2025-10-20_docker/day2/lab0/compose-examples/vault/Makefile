up:
	docker compose up -d --remove-orphans

down:
	docker compose down --remove-orphans

use-ports:
	echo COMPOSE_FILE=compose.yml:compose.ports.yml > .env

use-traefik-http:
	echo COMPOSE_FILE=compose.yml:compose.traefik-http.yml > .env

use-traefik-https:
	echo COMPOSE_FILE=compose.yml:compose.traefik-https.yml > .env
