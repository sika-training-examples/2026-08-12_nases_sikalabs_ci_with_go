resource "keycloak_group" "groups" {
  for_each = local.groups

  realm_id = keycloak_realm.example.id
  name     = each.key
}

resource "keycloak_group_roles" "group_roles" {
  for_each = local.groups

  realm_id = keycloak_realm.example.id
  group_id = keycloak_group.groups[each.key].id

  role_ids = [
    for role in each.value.roles :
    keycloak_role.roles[role].id
  ]
}
