terraform {
  required_providers {
    elasticstack = {
      source = "elastic/elasticstack"
    }
  }
}

variable "elastic_password" {}

provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = var.elastic_password
    endpoints = ["https://es.k8s3.sikademo.com:443"]
  }
  kibana {
    username  = "elastic"
    password  = var.elastic_password
    endpoints = ["https://kb.k8s3.sikademo.com:443"]
  }
}
