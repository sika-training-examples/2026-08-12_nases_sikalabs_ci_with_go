terraform {
  required_providers {
    elasticstack = {
      source = "elastic/elasticstack"
      version = "0.11.11"
    }
  }
}
provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = "q3fv4NT1YB7L0yL4X27M30WI"
    endpoints = ["https://es.k8s.sikademo.com:443"]
  }
  kibana {
    username  = "elastic"
    password  = "q3fv4NT1YB7L0yL4X27M30WI"
    endpoints = ["https://kb.k8s.sikademo.com:443"]
  }
}

resource "elasticstack_kibana_security_role" "traefik-read" {
  name     = "traefik-read"
  elasticsearch {
    indices {
      names      = ["xxx3-traefik-traefik-*"]
      privileges = ["read"]
    }
  }
  kibana {
    spaces = ["traefik"]
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

resource "elasticstack_elasticsearch_security_user" "bbb" {
  username = "bbb"

  password = "asdfasdf"
  roles         = [
    elasticstack_kibana_security_role.traefik-read.name,
  ]
}

resource "elasticstack_kibana_space" "tf" {
  space_id          = "tf"
  name              = "Terraform Space"
  disabled_features = [
    "actions",
    "advancedSettings",
    "apm",
    "canvas",
    "dev_tools",
    "discover",
    "filesManagement",
    "filesSharedImage",
    "fleet",
    "fleetv2",
    "generalCases",
    "guidedOnboardingFeature",
    "indexPatterns",
    "infrastructure",
    "logs",
    "maintenanceWindow",
    "maps",
    "ml",
    "monitoring",
    "observabilityCases",
    "osquery",
    "rulesSettings",
    "savedObjectsManagement",
    "savedObjectsTagging",
    "savedQueryManagement",
    "securitySolutionCases",
    "siem",
    "slo",
    "stackAlerts",
    "uptime",
    "visualize",
    "enterpriseSearch",
    "ingestManager",
  ]
  initials          = "TF"
}

resource "elasticstack_kibana_import_saved_objects" "settings" {
  overwrite     = true
  space_id = elasticstack_kibana_space.tf.space_id
  file_contents = file("traefik-dashboard.ndjson")
}

resource "elasticstack_kibana_security_role" "tf" {
  name     = "tf"
  elasticsearch {
    indices {
      names      = ["xxx3-traefik-traefik-*"]
      privileges = ["read"]
    }
  }
  kibana {
    spaces = [
        elasticstack_kibana_space.tf.space_id,
    ]
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

resource "elasticstack_elasticsearch_security_user" "tf" {
  username = "tf"

  password = "asdfasdf"
  roles         = [
    elasticstack_kibana_security_role.tf.name,
  ]
}

resource "elasticstack_elasticsearch_ingest_pipeline" "dissect" {
  name        = "dissect"
  processors = [
    <<EOF
    {
    "set": {
      "field": "message2",
      "copy_from": "message"
    }
  }
    EOF
    ,
    file("dissect.json"),
  ]
}
