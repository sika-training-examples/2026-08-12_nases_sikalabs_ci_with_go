resource "elasticstack_kibana_security_role" "hello-cez-read" {
  name = "hello-cez-read"
  elasticsearch {
    indices {
      names      = ["xxx-hello-cez"]
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

resource "elasticstack_kibana_security_role" "xxx-write" {
  name = "xxx-write"

  elasticsearch {
    indices {
      names      = ["xxx-*"]
      privileges = ["create_index", "create", "write", "view_index_metadata"]
    }
    cluster = ["monitor", "read_ilm", "manage_ilm", "manage", "all"]
  }
}
