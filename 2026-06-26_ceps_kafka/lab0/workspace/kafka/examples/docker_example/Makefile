default:
	@make up
	@make logs

up:
	docker compose up -d

logs:
	docker compose logs -f producer consumer

build:
	docker compose build

down:
	docker compose down
