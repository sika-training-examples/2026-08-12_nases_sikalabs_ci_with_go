variable "config" {
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    service_plan_id     = string
    docker_image_name   = string
    docker_registry_url = string
    worker_count        = optional(number, 1)
    https_only          = optional(bool, true)
    env                 = optional(map(string), {})
  })
}

resource "azurerm_user_assigned_identity" "this" {
  name                = "${var.config.name}-appservice"
  location            = var.config.location
  resource_group_name = var.config.resource_group_name
}

resource "azurerm_linux_web_app" "this" {
  app_settings = merge({
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }, var.config.env)
  name                = var.config.name
  location            = var.config.location
  resource_group_name = var.config.resource_group_name
  service_plan_id     = var.config.service_plan_id
  site_config {
    always_on    = false
    worker_count = var.config.worker_count
    application_stack {
      docker_image_name   = var.config.docker_image_name
      docker_registry_url = var.config.docker_registry_url
    }
  }
  ftp_publish_basic_authentication_enabled       = false
  https_only                                     = var.config.https_only
  webdeploy_publish_basic_authentication_enabled = false
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.this.id
    ]
  }
  key_vault_reference_identity_id = azurerm_user_assigned_identity.this.id
}

output "principal_id" {
  value = azurerm_user_assigned_identity.this.principal_id
}

output "tenant_id" {
  value = azurerm_user_assigned_identity.this.tenant_id
}
