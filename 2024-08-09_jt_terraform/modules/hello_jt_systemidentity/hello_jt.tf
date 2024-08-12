variable "env" {
  type        = string
  description = "Application environment (prod, stage, test, or dev)"
}

variable "worker_count" {
  type        = number
  description = "Number of workers"
  default     = 1
}

variable "tenant_id" {
  type        = string
  description = "Tenant ID"
}

variable "key_vault_id" {
  type        = string
  description = "Key Vault ID"
}

module "rg" {
  source = "../rg"
  name   = "hello-jt-${var.env}"
}

resource "azurerm_service_plan" "this" {
  name                = "hello-jt-${var.env}"
  resource_group_name = module.rg.name
  location            = module.rg.location
  os_type             = "Linux"
  sku_name            = "P1v2"
}

module "app" {
  source = "../app"

  config = {
    name                = "hello-jt-${var.env}"
    location            = azurerm_service_plan.this.location
    resource_group_name = azurerm_service_plan.this.resource_group_name
    service_plan_id     = azurerm_service_plan.this.id
    docker_image_name   = "sikalabs/hello-world-server"
    docker_registry_url = "https://index.docker.io"
    worker_count        = var.worker_count
    env = {
      PORT                = "80"
      TEXT                = "Hello J&T (${var.env})"
      "MY_SECRET_ENV_VAR" = "@Microsoft.KeyVault(VaultName=osdemojtkv999;SecretName=COLOR)"
    }
  }
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id       = var.key_vault_id
  tenant_id          = var.tenant_id
  object_id          = module.app.principal_id
  secret_permissions = ["Get"]
}

output "app" {
  value = module.app
}
