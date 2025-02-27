resource "keycloak_role" "realm1-admin" {
  realm_id = keycloak_realm.realm1.id
  name     = "admin"
}

resource "keycloak_role" "realm1-user" {
  realm_id = keycloak_realm.realm1.id
  name     = "user"
}
