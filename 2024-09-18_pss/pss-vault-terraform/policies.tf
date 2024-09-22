resource "vault_policy" "super-admin" {
  name   = "super-admin"
  policy = <<EOT
path "*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_policy" "read-all" {
  name   = "read-all"
  policy = <<EOT
path "secret/data/*" {
  capabilities = ["read", "list"]
}
EOT
}
