resource "vault_mount" "database" {
  path = "database"
  type = "database"
}

resource "vault_database_secret_backend_connection" "postgres" {
  backend       = vault_mount.database.path
  name          = "postgres"
  allowed_roles = ["default"]
  postgresql {
    connection_url = "postgresql://{{username}}:{{password}}@lab0.sikademo.com:5432/postgres?sslmode=disable"
    username       = "postgres"
    password       = "pg2024"
  }
}


resource "vault_database_secret_backend_role" "default" {
  name        = "default"
  backend     = vault_mount.database.path
  db_name     = vault_database_secret_backend_connection.postgres.name
  default_ttl = 2 * 60  // 2 minutes
  max_ttl     = 10 * 60 // 10 minutes
  creation_statements = [
    "CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}';",
    "GRANT ALL ON ALL TABLES IN SCHEMA public TO \"{{name}}\";",
  ]
}
