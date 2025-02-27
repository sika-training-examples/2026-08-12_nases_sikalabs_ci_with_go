resource "keycloak_role" "realm2-admin" {
  realm_id = keycloak_realm.realm2.id
  name     = "admin"
}

resource "keycloak_role" "realm2-user" {
  realm_id = keycloak_realm.realm2.id
  name     = "user"
}
