terraform-init-backend:
ifndef PG_CONN_STR
	$(error PG_CONN_STR is not set)
endif
	terraform init \
		-backend-config="conn_str=${PG_CONN_STR}"

run-postgres:
	docker run --name generali-terraform-state-postgres -e POSTGRES_PASSWORD=pg -d -p 5432:5432 postgres:16

backup-postgres:
	docker exec generali-terraform-state-postgres pg_dump -U postgres -d postgres > tmp/postgres.sql

infracost:
	infracost breakdown --path . --show-skipped

infracost-html:
	mkdir -p .infracost-reports
	infracost breakdown --path . --format=json --out-file .infracost-reports/report.json
	infracost output --path .infracost-reports/report.json --format html --out-file .infracost-reports/report.html
