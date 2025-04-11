terraform {
  required_providers {
    elasticstack = {
      source = "elastic/elasticstack"
    }
    slu = {
      source = "sikalabsx/slu"
    }
  }
}

variable "elastic_password" {}

provider "elasticstack" {
  elasticsearch {
    username  = "elastic"
    password  = var.elastic_password
    endpoints = ["https://es.k8s.sikademo.com:443"]
  }
  kibana {
    username  = "elastic"
    password  = var.elastic_password
    endpoints = ["https://kb.k8s.sikademo.com:443"]
  }
}
