terraform-init-backend:
ifndef POSTGRES_PASSWORD
	$(error POSTGRES_PASSWORD is not set)
endif
	terraform init -backend-config="conn_str=postgres://postgres:${POSTGRES_PASSWORD}@lab0.sikademo.com/postgres?sslmode=disable"
