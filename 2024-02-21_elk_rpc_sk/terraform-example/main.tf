terraform {
  backend "http" {}
  required_providers {
    elasticstack = {
      source = "elastic/elasticstack"
    }
    elasticsearch = {
      source  = "phillbaker/elasticsearch"
      version = "2.0.7"
    }
  }
}


variable "elasticsearch_endpoint" {}
variable "kibana_endpoint" {}
variable "elasticsearch_user" {}
variable "elasticsearch_password" {}

provider "elasticstack" {
  elasticsearch {
    endpoints = [var.elasticsearch_endpoint]
    username  = var.elasticsearch_user
    password  = var.elasticsearch_password
  }
  kibana {
    endpoints = [var.kibana_endpoint]
    username  = var.elasticsearch_user
    password  = var.elasticsearch_password
  }
}

provider "elasticsearch" {
  url      = var.elasticsearch_endpoint
  username = var.elasticsearch_user
  password = var.elasticsearch_password
}
