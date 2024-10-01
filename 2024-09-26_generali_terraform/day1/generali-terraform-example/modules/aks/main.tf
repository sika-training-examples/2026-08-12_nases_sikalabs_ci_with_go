resource "azurerm_resource_group" "this" {
  name     = var.name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "this" {
  lifecycle {
    ignore_changes = [
      tags,
    ]
  }
  name                              = var.name
  location                          = azurerm_resource_group.this.location
  resource_group_name               = azurerm_resource_group.this.name
  dns_prefix                        = var.name
  kubernetes_version                = var.kubernetes_version
  role_based_access_control_enabled = true
  tags                              = var.tags_common

  default_node_pool {
    name       = substr(replace(var.name, "-", ""), 0, 12)
    node_count = var.node_count
    vm_size    = var.vm_size

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    service_cidr      = "10.43.0.0/16"
    dns_service_ip    = "10.43.0.10"
    load_balancer_sku = "standard"
  }
}
