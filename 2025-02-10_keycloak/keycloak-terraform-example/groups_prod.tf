resource "keycloak_group" "grafana_admins" {
  realm_id = keycloak_realm.prod.id
  name     = "grafana-admins"
}

resource "keycloak_group" "grafana_viewers" {
  realm_id = keycloak_realm.prod.id
  name     = "grafana-viewers"
}

resource "keycloak_group" "realm_admins" {
  for_each = local.realms

  realm_id = each.value
  name     = "realm-admins"
}

data "keycloak_openid_client" "realm_management" {
  for_each = local.realms

  realm_id  = each.value
  client_id = "realm-management"
}

data "keycloak_role" "realm_admin" {
  for_each = local.realms

  realm_id  = each.value
  client_id = data.keycloak_openid_client.realm_management[each.value].id
  name      = "realm-admin"
}

resource "keycloak_group_roles" "group_roles" {
  for_each = local.realms

  realm_id = each.value
  group_id = keycloak_group.realm_admins[each.value].id

  role_ids = [
    data.keycloak_role.realm_admin[each.value].id,
  ]
}
