resource "elasticstack_kibana_security_role" "traefik-rw" {
  name     = "traefik-rw"
  elasticsearch {
    indices {
      names      = ["xxx3-traefik-traefik-*"]
      privileges = ["read", "write"]
    }
  }
  kibana {
    spaces = ["traefik"]
    feature {
      name       = "dashboard"
      privileges = ["all"]
    }
    feature {
      name       = "discover"
      privileges = ["all"]
    }
  }
}

resource "elasticstack_elasticsearch_security_user" "ccc" {
  username = "ccc"

  password = "asdfasdf"
  roles         = [
    elasticstack_kibana_security_role.traefik-rw.name,
  ]
}
