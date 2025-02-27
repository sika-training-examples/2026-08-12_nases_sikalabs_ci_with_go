locals {
  users = {
    dela = [
      "Dela", "Dela",
      [
        data.keycloak_role.realm-admin.id
      ],
      [
        keycloak_group.argocd-admins.id,
        keycloak_group.grafana-admins.id,
      ]
    ]
    nela = [
      "Nela", "Nela",
      [],
      [
        keycloak_group.argocd-viewers.id,
        keycloak_group.grafana-viewers.id,
      ]
    ]
    bela = [
      "Bela", "Bela",
      [],
      [
        keycloak_group.argocd-viewers.id,
        keycloak_group.grafana-viewers.id,
      ]
    ]
  }
}

resource "keycloak_user" "users" {
  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  for_each = local.users

  realm_id = keycloak_realm.example.id
  username = each.key
  enabled  = true

  email          = "${each.key}@example.com"
  email_verified = true
  first_name     = each.value[0]
  last_name      = each.value[1]

  initial_password {
    value     = "a"
    temporary = true
  }
}

resource "keycloak_user_roles" "users" {
  for_each = local.users

  realm_id = keycloak_realm.example.id
  user_id  = keycloak_user.users[each.key].id

  role_ids = each.value[2]
}

resource "keycloak_user_groups" "users" {
  for_each = local.users

  realm_id = keycloak_realm.example.id
  user_id  = keycloak_user.users[each.key].id

  group_ids = each.value[3]
}
