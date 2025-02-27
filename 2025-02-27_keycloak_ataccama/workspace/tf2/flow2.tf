resource "keycloak_authentication_flow" "realm2_idp_only_browser_flow" {
  realm_id = keycloak_realm.realm2.id
  alias    = "idp_only_browser_flow"
}

resource "keycloak_authentication_execution" "realm2_idp_only_browser_flow_01" {
  realm_id          = keycloak_realm.realm2.id
  parent_flow_alias = keycloak_authentication_flow.realm2_idp_only_browser_flow.alias
  authenticator     = "identity-provider-redirector"
  requirement       = "REQUIRED"
}

resource "keycloak_authentication_execution_config" "realm2_idp_only_browser_flow_01" {
  realm_id     = keycloak_realm.realm2.id
  execution_id = keycloak_authentication_execution.realm2_idp_only_browser_flow_01.id
  alias        = "identity-provider-redirector"
  config = {
    defaultProvider = keycloak_oidc_identity_provider.realm2.id
  }
}

resource "keycloak_authentication_bindings" "realm2_browser_authentication_binding" {
  realm_id     = keycloak_realm.realm2.id
  browser_flow = keycloak_authentication_flow.realm2_idp_only_browser_flow.alias
}
