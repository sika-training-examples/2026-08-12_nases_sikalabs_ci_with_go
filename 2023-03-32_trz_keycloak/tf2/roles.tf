resource "keycloak_role" "roles" {
  for_each = local.roles

  realm_id = keycloak_realm.example.id
  name     = each.key
}
