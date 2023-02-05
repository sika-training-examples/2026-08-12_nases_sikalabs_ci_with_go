up:
	docker compose up -d
	echo See http://127.0.0.1:5601

down:
	docker compose down

down-with-volumes:
	docker compose down --volumes

get-ca:
	docker compose cp es01:/usr/share/elasticsearch/config/certs/ca/ca.crt ./ca.crt

filebeat:
	filebeat -c $(shell pwd)/filebeat.yml

filebeat-verbose:
	filebeat -c $(shell pwd)/filebeat.yml -e
