variable "realm1_name" {}

resource "keycloak_realm" "realm1" {
  realm                          = var.realm1_name
  enabled                        = true
  display_name                   = "Realm1 SSO"
  display_name_html              = "<h1>Realm1 SSO</h1>"
  reset_password_allowed         = true
  registration_allowed           = true
  registration_email_as_username = false

  smtp_server {
    host = "maildev2.sikademo.com"
    port = "1025"
    from = "keycloak@kc0.com"
  }
}

resource "keycloak_realm_user_profile" "realm1" {
  realm_id = keycloak_realm.realm1.id

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

resource "keycloak_openid_client_scope" "realm1_department" {
  realm_id               = keycloak_realm.realm1.id
  name                   = "department"
  include_in_token_scope = true
}

resource "keycloak_generic_protocol_mapper" "realm1_department" {
  realm_id        = keycloak_realm.realm1.id
  client_scope_id = keycloak_openid_client_scope.realm1_department.id
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

resource "keycloak_openid_client_scope" "realm1_groups" {
  realm_id               = keycloak_realm.realm1.id
  name                   = "groups"
  include_in_token_scope = true
}

resource "keycloak_openid_group_membership_protocol_mapper" "realm1_groups" {
  realm_id        = keycloak_realm.realm1.id
  client_scope_id = keycloak_openid_client_scope.realm1_groups.id

  name       = keycloak_openid_client_scope.realm1_groups.name
  claim_name = keycloak_openid_client_scope.realm1_groups.name
  full_path  = false
}

resource "keycloak_openid_client_scope" "realm1_myroles" {
  realm_id               = keycloak_realm.realm1.id
  name                   = "myroles"
  include_in_token_scope = true
}

resource "keycloak_openid_user_realm_role_protocol_mapper" "user_realm_role_mapper" {
  realm_id        = keycloak_realm.realm1.id
  client_scope_id = keycloak_openid_client_scope.realm1_myroles.id

  name = "user-realm-role-mapper"

  claim_name  = "roles"
  multivalued = true
}
