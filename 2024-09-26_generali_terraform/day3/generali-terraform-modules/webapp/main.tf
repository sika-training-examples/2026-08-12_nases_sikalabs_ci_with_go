resource "azurerm_linux_web_app" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = var.service_plan_id

  site_config {
    application_stack {
      docker_image_name   = var.docker_image_name
      docker_registry_url = var.docker_registry_url
    }
    worker_count = var.worker_count
  }

  app_settings = var.env
}
