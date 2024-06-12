terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "4.2.0"
    }
  }
}

provider "vault" {
  address = "https://vault.k8s.sikademo.com"
  token   = "hvs.nVfmb8b7z8gCdZOWZfVweYK7"
}

resource "vault_kv_secret_v2" "example" {
  lifecycle {
    ignore_changes = [
      data_json,
    ]
  }

  mount = "secret/"
  name  = "example"
  data_json = jsonencode(
    {
      zip = "__CHANGE_ME__"
      foo = "__CHANGE_ME__"
    }
  )
}
resource "vault_kv_secret_v2" "example2" {
  lifecycle {
    ignore_changes = [data_json]
  }

  mount = "secret/"
  name  = "example2"
  data_json = jsonencode(
    {
      zip = "__CHANGE_ME__"
      foo = "__CHANGE_ME__"
    }
  )
}
