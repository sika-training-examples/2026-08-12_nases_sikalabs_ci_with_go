resource "elasticstack_kibana_security_role" "hello-cez-read" {
  name = "hello-cez-read"
  elasticsearch {
    indices {
      names      = ["kafka3-hello-cez"]
      privileges = ["read"]
    }
  }
  kibana {
    spaces = [elasticstack_kibana_space.cez.space_id]
    feature {
      name       = "dashboard"
      privileges = ["read"]
    }
    feature {
      name       = "discover"
      privileges = ["read"]
    }
  }
}
