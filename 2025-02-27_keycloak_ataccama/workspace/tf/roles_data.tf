data "keycloak_role" "realm-admin" {
  realm_id  = keycloak_realm.example.id
  client_id = data.keycloak_openid_client.realm_management.id
  name      = "realm-admin"
}
