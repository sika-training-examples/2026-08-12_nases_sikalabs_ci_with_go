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
    min_age = "1m"
    delete {}
  }
}

resource "elasticstack_elasticsearch_index_template" "max10" {
  name           = "max10"
  index_patterns = ["max10*"]
  data_stream {}
  template {
    settings = jsonencode({
      "lifecycle.name" = elasticstack_elasticsearch_index_lifecycle.max_10_docs.name
    })
  }
}

resource "elasticstack_elasticsearch_data_stream" "max10" {
  name = elasticstack_elasticsearch_index_template.max10.name
}
