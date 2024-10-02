terraform {
  backend "pg" {
    schema_name = "ondrejsika_kubernetes"
  }

  required_providers {
    harbor = {
      source  = "goharbor/harbor"
      version = "3.10.15"
    }
    null = {
      source  = "hashicorp/null"
      version = "3.2.2"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.25.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.0"
    }
  }
}

variable "rancher2_token_key" {}

provider "rancher2" {
  api_url   = "https://rancher.k8s.sikademo.com/v3"
  token_key = var.rancher2_token_key
}

variable "harbor_username" {}
variable "harbor_password" {}

provider "harbor" {
  url      = "https://harbor.k8s.sikademo.com"
  username = var.harbor_username
  password = var.harbor_password
}
