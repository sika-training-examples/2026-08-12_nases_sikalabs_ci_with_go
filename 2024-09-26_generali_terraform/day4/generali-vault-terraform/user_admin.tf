
resource "vault_identity_entity" "admin" {
  name = "admin-entity"
  policies = [
    vault_policy.super-admin.name,
  ]
}

resource "vault_generic_endpoint" "userpass_admin" {
  depends_on = [
    vault_auth_backend.userpass,
  ]
  path                 = "auth/userpass/users/admin"
  ignore_absent_fields = true

  data_json = jsonencode({
    // password is "admin"
    password_hash = "$2a$10$6v.IYEpyAqYYLOkzHJbXv.Q931FE5HOeNr.WfuEcn1KeunpsN1zHq",
  })
}

resource "vault_identity_entity_alias" "userpass_admin" {
  name           = "admin"
  mount_accessor = vault_auth_backend.userpass.accessor
  canonical_id   = vault_identity_entity.admin.id
}
