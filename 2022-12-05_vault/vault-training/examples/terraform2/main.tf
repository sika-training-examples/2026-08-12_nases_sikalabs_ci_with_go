terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "3.11.0"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}

variable "vault_address" {
  type = string
}

variable "vault_token" {
  type = string
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

resource "vault_auth_backend" "userpass" {
  type = "userpass"
}

resource "vault_policy" "admin" {
  name = "admin"

  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_identity_entity" "admin" {
  name      = "admin"
  policies  = [
    vault_policy.admin.name,
  ]
}

resource "vault_generic_endpoint" "userpass_admin" {
  path                 = "auth/${vault_auth_backend.userpass.path}/users/admin"
  ignore_absent_fields = true

  data_json = jsonencode(
    {
      "password" = "a"
    }
  )
}

resource "vault_identity_entity_alias" "userpass_admin" {
  depends_on = [
    vault_generic_endpoint.userpass_admin,
  ]
  name           = "admin"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.admin.id
}


resource "vault_mount" "secret" {
  path        = "secret/"
  type        = "kv"
  options     = { version = "2" }
}

resource "vault_generic_secret" "foo_bar" {
  lifecycle {
    ignore_changes = [
      data_json,
    ]    
  }

  path = "${vault_mount.secret.path}foo/bar"

  data_json = sensitive(jsonencode(
    {
      "ACCESS_KEY"  = "CHANGE_ME"
      "SECRET_KEY"  = "CHANGE_ME"
      "REGION"      = "CHANGE_ME"
      "ENDPOINT"    = "CHANGE_ME"
      "BUCKET_NAME" = "CHANGE_ME"
    }
  ))
}


resource "vault_generic_secret" "hello_world" {
  lifecycle {
    ignore_changes = [
      data_json,
    ]    
  }

  path = "${vault_mount.secret.path}hello/world"

  data_json = sensitive(jsonencode(
    {
      "HELLO"  = "CHANGE_ME"
      "WORLD"  = "CHANGE_ME"
    }
  ))
}

resource "vault_database_secrets_mount" "database" {
  path = "database"

  postgresql {
    name              = "postgres"
    username          = "postgres"
    password          = "pg"
    connection_url    = "postgresql://{{username}}:{{password}}@lab0.sikademo.com:5432/postgres"
    verify_connection = true
    allowed_roles = [
      "postgres",
    ]
  }
}

resource "vault_database_secret_backend_role" "postgres" {
  name    = "postgres"
  backend = vault_database_secrets_mount.database.path
  db_name = vault_database_secrets_mount.database.postgresql[0].name
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
  ]
}

