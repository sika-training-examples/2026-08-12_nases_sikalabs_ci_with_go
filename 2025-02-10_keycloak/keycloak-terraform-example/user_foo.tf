resource "keycloak_user" "foo" {
  lifecycle {
    ignore_changes = [
      required_actions,
    ]
  }

  for_each = local.realms

  realm_id = each.value
  username = "foo"
  enabled  = true

  email          = "foo@example.com"
  email_verified = true
  first_name     = "Foo"
  last_name      = "Sika"

  required_actions = [
    "VERIFY_EMAIL",
  ]
}

resource "smtp_send_mail" "foo" {
  for_each = local.realms

  to      = [keycloak_user.foo[each.key].email]
  from    = "sso@example.com"
  subject = "New SSO User"
  body    = "https://keycloak.sikademo.com/realms/${each.key}/login-actions/reset-credentials"
}


resource "keycloak_user_groups" "foo" {
  realm_id = keycloak_realm.prod.id
  user_id  = keycloak_user.foo["prod"].id

  group_ids = [
    keycloak_group.grafana_viewers.id,
  ]
}

resource "keycloak_user_roles" "foo" {
  realm_id = keycloak_realm.prod.id
  user_id  = keycloak_user.foo["prod"].id

  role_ids = [
    keycloak_role.viewer.id,
  ]
}
