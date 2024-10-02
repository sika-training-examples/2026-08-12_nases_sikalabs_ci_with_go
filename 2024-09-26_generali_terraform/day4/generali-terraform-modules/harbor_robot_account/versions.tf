terraform {
  required_providers {
    harbor = {
      source  = "goharbor/harbor"
      version = "3.10.15"
    }
  }
  required_version = ">= 1.0.0"
}
