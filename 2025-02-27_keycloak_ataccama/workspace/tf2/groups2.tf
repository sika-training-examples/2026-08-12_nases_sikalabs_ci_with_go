resource "keycloak_group" "realm2-admins" {
  realm_id = keycloak_realm.realm2.id
  name     = "admins"
}

resource "keycloak_group" "realm2-viewers" {
  realm_id = keycloak_realm.realm2.id
  name     = "viewers"
}

resource "keycloak_group" "realm2-imported" {
  realm_id = keycloak_realm.realm2.id
  name     = "imported"
}
