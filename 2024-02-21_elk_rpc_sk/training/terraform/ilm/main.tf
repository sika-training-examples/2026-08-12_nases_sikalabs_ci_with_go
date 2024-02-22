terraform {
  required_providers {
    elasticstack = {
      source  = "elastic/elasticstack"
      version = "0.5.0"
    }
  }
}

variable "elasticstack_elasticsearch_endpoint" {
  default = "https://es.k8s.sikademo.com"
}
variable "elasticstack_elasticsearch_password" {}

provider "elasticstack" {
  elasticsearch {
    endpoints = [var.elasticstack_elasticsearch_endpoint]
    username  = "elastic"
    password  = var.elasticstack_elasticsearch_password
  }
}

resource "elasticstack_elasticsearch_index_lifecycle" "max_10_docs" {
  name = "max_10_docs"

  hot {
    rollover {
      max_docs = 10
    }
    readonly {}
  }

  delete {
    min_age = "5m"
    delete {}
  }
}

resource "elasticstack_elasticsearch_index_template" "foo" {
  name           = "foo"
  index_patterns = ["foo*"]
  data_stream {}
  template {
    settings = jsonencode({
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.max_10_docs.name
    })
  }
}

resource "elasticstack_elasticsearch_data_stream" "foo" {
  name = elasticstack_elasticsearch_index_template.foo.name
}

resource "elasticstack_elasticsearch_index_template" "bar" {
  name           = "bar"
  index_patterns = ["bar*"]
  data_stream {}
  template {
    settings = jsonencode({
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.max_10_docs.name
    })
  }
}

resource "elasticstack_elasticsearch_data_stream" "bar" {
  name = elasticstack_elasticsearch_index_template.bar.name
}
