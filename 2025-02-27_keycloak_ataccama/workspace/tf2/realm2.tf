variable "realm2_name" {}

resource "keycloak_realm" "realm2" {
  realm                          = var.realm2_name
  enabled                        = true
  display_name                   = "Realm2 SSO"
  display_name_html              = "<h1>Realm2 SSO</h1>"
  reset_password_allowed         = true
  registration_allowed           = true
  registration_email_as_username = false

  smtp_server {
    host = "maildev2.sikademo.com"
    port = "1025"
    from = "keycloak@kc0.com"
  }
}

resource "keycloak_realm_user_profile" "realm2" {
  realm_id = keycloak_realm.realm2.id


  attribute {
    name = "username"

    permissions {
      edit = ["admin"]
      view = ["user"]
    }
  }

  attribute {
    name = "email"

    permissions {
      edit = ["admin"]
      view = ["user"]
    }

    validator {
      name = "email"
    }
  }

  attribute {
    name = "firstName"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }

  attribute {
    name = "lastName"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }

  attribute {
    name         = "department"
    display_name = "Department"

    permissions {
      view = ["admin", "user"]
      edit = ["admin", "user"]
    }
  }
}

resource "keycloak_oidc_identity_provider" "realm2" {
  realm             = keycloak_realm.realm2.id
  alias             = keycloak_realm.realm1.realm
  authorization_url = "${var.keycloak_url}/realms/${keycloak_realm.realm1.realm}/protocol/openid-connect/auth"
  client_id         = keycloak_openid_client.realm1_idp.client_id
  client_secret     = keycloak_openid_client.realm1_idp.client_secret
  token_url         = "${var.keycloak_url}/realms/${keycloak_realm.realm1.realm}/protocol/openid-connect/token"

  extra_config = {
    "clientAuthMethod" = "client_secret_post"
  }
}

resource "keycloak_attribute_importer_identity_provider_mapper" "realm2_department" {
  realm                   = keycloak_realm.realm2.id
  name                    = "department-attribute-importer"
  claim_name              = "department"
  identity_provider_alias = keycloak_oidc_identity_provider.realm2.alias
  user_attribute          = "department"

  extra_config = {
    syncMode = "INHERIT"
  }
}

resource "keycloak_openid_client_scope" "realm2_department" {
  realm_id               = keycloak_realm.realm2.id
  name                   = "department"
  include_in_token_scope = true
}

resource "keycloak_generic_protocol_mapper" "realm2_department" {
  realm_id        = keycloak_realm.realm2.id
  client_scope_id = keycloak_openid_client_scope.realm2_department.id
  name            = "department-attribute-mapper"
  protocol        = "openid-connect"
  protocol_mapper = "oidc-usermodel-attribute-mapper"

  config = {
    "introspection.token.claim" = "true"
    "claim.name"                = "department"
    "jsonType.label"            = "String"
    "user.attribute"            = "department"
    "id.token.claim"            = "true"
    "access.token.claim"        = "true"
    "userinfo.token.claim"      = "true"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "realm2-role-admin" {
  realm                   = keycloak_realm.realm2.id
  name                    = "admin-role-attribute"
  identity_provider_alias = keycloak_oidc_identity_provider.realm2.alias
  role                    = keycloak_role.realm2-admin.name
  claim_name              = "roles"
  claim_value             = keycloak_role.realm1-admin.name

  # extra_config with syncMode is required in Keycloak 10+
  extra_config = {
    syncMode = "FORCE"
  }
}

resource "keycloak_attribute_to_role_identity_provider_mapper" "realm2-role-user" {
  realm                   = keycloak_realm.realm2.id
  name                    = "user-role-attribute"
  identity_provider_alias = keycloak_oidc_identity_provider.realm2.alias
  role                    = keycloak_role.realm2-user.name
  claim_name              = "roles"
  claim_value             = keycloak_role.realm1-user.name

  # extra_config with syncMode is required in Keycloak 10+
  extra_config = {
    syncMode = "FORCE"
  }
}

resource "keycloak_openid_client_scope" "realm2_groups" {
  realm_id               = keycloak_realm.realm2.id
  name                   = "groups"
  include_in_token_scope = true
}

resource "keycloak_openid_group_membership_protocol_mapper" "realm2_groups" {
  realm_id        = keycloak_realm.realm2.id
  client_scope_id = keycloak_openid_client_scope.realm2_groups.id

  name       = keycloak_openid_client_scope.realm2_groups.name
  claim_name = keycloak_openid_client_scope.realm2_groups.name
  full_path  = false
}
