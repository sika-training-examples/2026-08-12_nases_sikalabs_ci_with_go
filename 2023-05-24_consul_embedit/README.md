[Ondrej Sika (sika.io)](https://sika.io) | <ondrej@sika.io>

# Consul Training

## Install Consul Server for Development

- https://developer.hashicorp.com/consul/downloads

Mac

```
brew install consul
```

Linux (using [slu](https://github.com/sikalabs/slu))

```
slu install-bin consul
```

## Run Consul Agent in Dev Mode

```
consul agent -server -dev -node localhost
```

See: http://127.0.0.1:8500

Check the members of the cluster (dc)

```
consul members
```

```
consul members -detailed
```

```
curl http://127.0.0.1:8500/v1/catalog/nodes
```

or see: http://127.0.0.1:8500/v1/catalog/nodes

## Run Consul in Dev Mode on Lab VM

Set public ip of your lab VM

```
IP=$(slu ip)
```

Run Consul Server

```
consul agent -server -dev -node localhost -client 0.0.0.0 -bind $IP -datacenter fra
```

or

```
make run-consul-dev-lab
```

## Consul Environment Variables

<https://developer.hashicorp.com/consul/commands#environment-variables>

```
export CONSUL_HTTP_ADDR=
```

```
export CONSUL_HTTP_TOKEN=
```

## Service Discovery

### Register Service using Consul CLI (from file)

```
consul services register examples/service-foo-1-cli.json
```

### Register Service using Curl (from file)

```
curl -X PUT -d @examples/service-foo-2-curl.json http://127.0.0.1:8500/v1/agent/service/register
```

### Register Service using Consul CLI (from args)

No support for health checks

```
consul services register -name foo -id foo-3 -address 127.0.0.1 -port 39001 -tag web
```

### Register Service using Consul Agent

Run dev consul with config file `examples/agent-1.hcl`

```
consul agent -server -dev -node localhost -config-file ./examples/agent-1.hcl
```

### List Services using Consul CLI

List services

```
consul catalog services
```

List services with tags

```
consul catalog services -tags
```

### List Services using Consul API

```
curl http://127.0.0.1:8500/v1/catalog/services
```

### List Services using Consul UI

See: http://127.0.0.1:8500/ui/dc1/services

### Get Addresses of Service using DNS

```
dig @127.0.0.1 -p 8600 foo.service.consul +short
```

```
dig @127.0.0.1 -p 8600 bar.service.consul +short
```

### Get Endpoints of Service using HTTP API

```
curl http://127.0.0.1:8500/v1/catalog/service/foo
```

use jq to get only address and port

```
curl http://127.0.0.1:8500/v1/catalog/service/foo | jq -r '.[] | "\(.ServiceAddress):\(.ServicePort)"'
```

### Deregister Service using CLI

```
consul services deregister -id foo-1
```

### Deregister Service using Curl

```
curl -X PUT http://127.0.0.1:8500/v1/agent/service/deregister/foo-2
```

## Consul Key Value Store

```
consul kv
```

### Write data using CLI

```
consul kv put redis/config/connections 5
```

### Read data using CLI

```
consul kv get redis/config/connections
```

### Write data using Curl

```
curl -X PUT --data 'bar' http://127.0.0.1:8500/v1/kv/foo
```

### Read data using Curl

```
curl http://127.0.0.1:8500/v1/kv/foo
```

```
curl -fsSL http://127.0.0.1:8500/v1/kv/foo | jq -r ".[].Value" | base64 --decode
```

## Backup & Restore

### Backup using CLI

```
consul snapshot save backup.snap
```

### Restore using CLI

```
consul snapshot restore backup.snap
```

### Backup using HTTP API

```
curl http://localhost:8500/v1/snapshot -o backup-curl.snap
```

### Restore using HTTP API

```
curl -X PUT --data-binary @backup-curl.snap http://127.0.0.1:8500/v1/snapshot
```

### Backup using Tergum

```
tergum backup -c examples/tergum-1.yml
```

Restore using CLI

```
consul snapshot restore backup-tergum.snap
```

## ACL

### Run server with ACL

```
consul agent -server -dev -node localhost -config-file=examples/dev-acl.hcl
```

or

```
run-consul-dev-acl
```

### Bootstrap ACL

```
consul acl bootstrap
```

### Consul & Terraform

<https://registry.terraform.io/providers/hashicorp/consul/latest/docs>

## Thank you! & Questions?

That's it. Do you have any questions? **Let's go for a beer!**

### Ondrej Sika

- email: <ondrej@sika.io>
- web: <https://sika.io>
- twitter: [@ondrejsika](https://twitter.com/ondrejsika)
- linkedin: [/in/ondrejsika/](https://linkedin.com/in/ondrejsika/)
- Newsletter, Slack, Facebook & Linkedin Groups: <https://join.sika.io>

_Do you like the course? Write me recommendation on Twitter (with handle `@ondrejsika`) and LinkedIn (add me [/in/ondrejsika](https://www.linkedin.com/in/ondrejsika/) and I'll send you request for recommendation). **Thanks**._

Wanna to go for a beer or do some work together? Just [book me](https://book-me.sika.io) :)
