up:
	docker compose up -d
	echo See http://127.0.0.1:5601

down:
	docker compose down

create-enrollment-token:
	docker compose exec elasticsearch bin/elasticsearch-create-enrollment-token --scope kibana

kibana-verification-code:
	docker compose exec kibana bin/kibana-verification-code

elastic-password-reset:
	docker compose exec elasticsearch bin/elasticsearch-reset-password -u elastic --batch

get-ca:
	docker compose cp elasticsearch:/usr/share/elasticsearch/config/certs/http_ca.crt ./ca.crt

filebeat:
	filebeat -c $(shell pwd)/filebeat.yml

filebeat-verbose:
	filebeat -c $(shell pwd)/filebeat.yml -e
