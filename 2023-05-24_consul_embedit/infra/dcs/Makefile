consul:
	gobble run --only-tag consul

all:
	gobble run

foo:
	curl http://127.0.0.1:8500/v1/query \
			--request POST \
			--data '{"Name": "foo","Service": {"Service": "foo","Failover": {"NearestN": 2}}}'
