variable "admin_password_hash" {}

module "vault" {
  source              = "git::ssh://git@gitlab.sikalabs.com/sikalabs-platform-terraform/sikalabs-platform-terraform-module-vault.git"
  vault_address       = var.vault_address
  admin_password_hash = var.admin_password_hash
  oidc_discovery_url  = "https://sso.sikalabs.com/realms/training"
  oidc_client_id      = "example_client_id"
  oidc_client_secret  = "example_client_secret"
  disable_oidc        = false
}
