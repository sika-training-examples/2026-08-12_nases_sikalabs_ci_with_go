terraform {
  required_providers {
    consul = {
      source  = "hashicorp/consul"
      version = "2.17.0"
    }
  }
}

provider "consul" {
  address = "http://acl21.sikademo.com:8500"
  token   = "1c752465-459a-7549-88bd-6b8662d4ac54"
}

resource "consul_acl_policy" "acl22" {
  name  = "acl22"
  rules = <<-RULE
node "acl22" {
  policy = "write"
}
RULE
}

resource "consul_acl_policy" "acl23" {
  name  = "acl23"
  rules = <<-RULE
node "acl23" {
  policy = "write"
}
RULE
}

resource "consul_acl_policy" "service-demo" {
  name  = "service-demo"
  rules = <<-RULE
service "demo" {
  policy = "write"
}
RULE
}


resource "consul_acl_policy" "service-not-demo" {
  name  = "service-not-demo"
  rules = <<-RULE
service "demo" {
  policy = "deny"
}

service_prefix "" {
  policy = "write"
}
RULE
}

resource "consul_acl_token" "acl22" {
  description = "acl22"
  policies = [
    consul_acl_policy.service-demo.name,
    consul_acl_policy.acl22.name,
  ]
}


resource "consul_acl_token" "acl23" {
  description = "acl23"
  policies = [
    consul_acl_policy.acl23.name,
    consul_acl_policy.service-not-demo.name,
  ]
}
