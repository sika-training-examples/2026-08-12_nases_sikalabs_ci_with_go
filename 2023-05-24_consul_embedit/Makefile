run-consul-dev:
	consul agent -server -dev -node localhost

run-consul-dev-acl:
	consul agent -server -dev -node localhost -config-file=examples/dev-acl.hcl

run-consul-dev-lab:
	consul agent -server -dev -node localhost -client 0.0.0.0 -bind $(shell slu ip) -datacenter fra

run-service-foo-1:
	TEXT="foo-1" PORT=19001 hello-world-server

run-service-foo-2:
	TEXT="foo-2" PORT=29001 hello-world-server

run-service-foo-3:
	TEXT="foo-3" PORT=39001 hello-world-server

run-service-bar-1:
	TEXT="bar-1" PORT=19002 hello-world-server

run-service-bar-2:
	TEXT="bar-2" PORT=29002 hello-world-server

run-service-bar-3:
	TEXT="bar-3" PORT=39002 hello-world-server


prepared-query-1:
	curl http://127.0.0.1:8500/v1/query \
			--request POST \
			--data '{"Name": "svc-foo-v0-1","Service": {"Service": "svc-foo", "tags": ["v0.1"]}}'

prepared-query-2:
	curl http://127.0.0.1:8500/v1/query \
			--request POST \
			--data '{"Name": "svc-foo-v0-2","Service": {"Service": "svc-foo", "tags": ["v0.2"]}}'

prepared-query-3:
	curl http://127.0.0.1:8500/v1/query \
			--request POST \
			--data '{"Name": "svc-foo-prod","Service": {"Service": "svc-foo", "tags": ["v0.1"]}}'
	curl http://127.0.0.1:8500/v1/query \
			--request POST \
			--data '{"Name": "svc-foo-exp","Service": {"Service": "svc-foo", "tags": ["v0.2"]}}'

prepared-query-4:
	curl http://127.0.0.1:8500/v1/query \
			--request PUT \
			--data '{"Name": "svc-foo-prod","Service": {"Service": "svc-foo", "tags": ["v0.2"]}}'
	curl http://127.0.0.1:8500/v1/query \
			--request PUT \
			--data '{"Name": "svc-foo-exp","Service": {"Service": "svc-foo", "tags": ["v0.3"]}}'
