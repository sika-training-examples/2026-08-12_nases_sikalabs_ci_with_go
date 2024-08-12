variable "env" {
  type        = string
  description = "Application environment (prod, stage, test, or dev)"
}

variable "worker_count" {
  type        = number
  description = "Number of workers"
  default     = 1
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account"
}

variable "location" {
  type        = string
  description = "The location of the resource group in which to create the storage account"
}

resource "azurerm_service_plan" "this" {
  name                = "hello-jt-${var.env}"
  resource_group_name = var.resource_group_name
  location            = var.location
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
      PORT = "80"
      TEXT = "Hello J&T (${var.env})"
    }
  }
}
