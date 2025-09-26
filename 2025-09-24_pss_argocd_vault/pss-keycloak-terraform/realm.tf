resource "keycloak_realm" "pss" {
  realm                    = "pss"
  enabled                  = true
  display_name_html        = "<h1 style=\"color: #004898; font-weight: bold;\">PPS SSO</h1>"
  login_with_email_allowed = true
  login_theme              = "pss"
  reset_password_allowed   = true
  remember_me              = true
}

resource "keycloak_realm_events" "pss" {
  lifecycle {
    ignore_changes = [
      events_listeners,
    ]
  }

  realm_id = keycloak_realm.pss.id

  events_enabled    = true
  events_expiration = 3600

  admin_events_enabled         = true
  admin_events_details_enabled = true
}

resource "keycloak_openid_client_scope" "pss_groups" {
  realm_id               = keycloak_realm.pss.id
  name                   = "groups"
  include_in_token_scope = true
  gui_order              = 1
}

resource "keycloak_openid_group_membership_protocol_mapper" "pss_groups" {
  realm_id        = keycloak_realm.pss.id
  client_scope_id = keycloak_openid_client_scope.pss_groups.id
  name            = "groups"
  claim_name      = "groups"
  full_path       = false
}
