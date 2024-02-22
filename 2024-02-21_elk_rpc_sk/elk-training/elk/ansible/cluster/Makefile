play:
	ansible-playbook playbook.yml

get-ca:
	scp root@es1.sikademo.com:/etc/elasticsearch/certs/http_ca.crt ./ca.crt

filebeat:
	filebeat -c $(shell pwd)/filebeat.yml

filebeat-verbose:
	filebeat -c $(shell pwd)/filebeat.yml -e
