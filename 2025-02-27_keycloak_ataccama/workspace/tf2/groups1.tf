resource "keycloak_group" "realm1-admins" {
  realm_id = keycloak_realm.realm1.id
  name     = "admins"
}

resource "keycloak_group" "realm1-viewers" {
  realm_id = keycloak_realm.realm1.id
  name     = "viewers"
}
