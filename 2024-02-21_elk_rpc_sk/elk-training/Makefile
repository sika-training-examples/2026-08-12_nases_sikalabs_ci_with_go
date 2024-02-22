run-loggen-text-file:
	slu loggen \
		--log-prefix loggen-text \
		--log-file /tmp/example-log-text.log

run-loggen-text-file-docker:
	docker run --name loggen-text-docker -d \
		-v /tmp:/tmp \
		sikalabs/slu:v0.60.0-dev-2 \
			slu loggen \
				--log-prefix loggen-text-docker \
				--log-file /tmp/example-log-text.log

run-loggen-json-file:
	slu loggen \
		--json \
		--log-prefix loggen-json \
		--log-file /tmp/example-log-json.log

run-loggen-json-file-docker:
	docker run --name loggen-json-docker -d \
		-v /tmp:/tmp \
		sikalabs/slu:v0.60.0-dev-2 \
			slu loggen \
				--json \
				--log-prefix loggen-json-docker \
				--log-file /tmp/example-log-json.log

run-counter-file:
	slu scripts counter > /tmp/example-log-counter.log

run-counter-file-docker:
	docker run --name loggen-counter -d \
		-v /tmp:/tmp \
		sikalabs/slu:v0.60.0-dev-2 \
			bash -c "slu scripts counter > /tmp/example-log-counter.log"
