resource "keycloak_user" "users2" {
  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  for_each = local.users

  realm_id = keycloak_realm.example2.id
  username = each.key
  enabled  = true

  email          = "${each.key}@example.com"
  email_verified = true
  first_name     = each.value[0]
  last_name      = each.value[1]

  federated_identity {
    identity_provider = keycloak_oidc_identity_provider.example2.id
    user_id           = keycloak_user.users[each.key].id
    user_name         = keycloak_user.users[each.key].username
  }
}
