resource "vault_policy" "super-admin" {
  name   = "super-admin"
  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_policy" "read-secrets" {
  name   = "read-secrets"
  policy = <<EOT
path "secret/data/*" {
  capabilities = ["read", "list"]
}

path "database/*" {
  capabilities = ["read", "list"]
}
EOT
}
