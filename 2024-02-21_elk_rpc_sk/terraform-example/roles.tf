resource "elasticstack_kibana_security_role" "demo_read" {
  name = "demo_read"
  elasticsearch {
    cluster = []
    indices {
      names      = ["filebeat-*", "sika-mac-*"]
      privileges = ["read"]
    }
  }
  kibana {
    feature {
      name = "dashboard"
      privileges = [
        "read",
      ]
    }
    feature {
      name = "discover"
      privileges = [
        "read",
      ]
    }
    feature {
      name = "logs"
      privileges = [
        "read",
      ]
    }
    spaces = [elasticstack_kibana_space.demo.id]
  }
}

resource "elasticstack_kibana_security_role" "foo_read" {
  name = "foo"
  elasticsearch {
    cluster = []
    indices {
      names      = ["filebeat-*", "sika-mac-*"]
      privileges = ["read"]
    }
  }
  kibana {
    feature {
      name = "dashboard"
      privileges = [
        "read",
      ]
    }
    feature {
      name = "discover"
      privileges = [
        "read",
      ]
    }
    feature {
      name = "logs"
      privileges = [
        "read",
      ]
    }
    spaces = [elasticstack_kibana_space.foo.id]
  }
}
