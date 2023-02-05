up:
	docker compose up -d
	echo See http://127.0.0.1:5601

down:
	docker compose down

filebeat:
	filebeat -c $(shell pwd)/filebeat.yml

filebeat-verbose:
	filebeat -c $(shell pwd)/filebeat.yml -e
