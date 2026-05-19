resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${local.prefix}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-${local.prefix}"

  default_node_pool {
    name           = "system"
    node_count     = 1
    vm_size        = "Standard_D2s_v3"
    vnet_subnet_id = azurerm_subnet.aks.id

    upgrade_settings {
      drain_timeout_in_minutes      = 0
      max_surge                     = "10%"
      node_soak_duration_in_minutes = 0
    }
  }

  identity {
    type = "SystemAssigned"
  }

  oms_agent {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.law.id
  }

  network_profile {
    network_plugin = "azure"
    service_cidr   = "10.43.0.0/16"
    dns_service_ip = "10.43.0.10"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vm_size               = "Standard_D4s_v3"
  node_count            = 1
  vnet_subnet_id        = azurerm_subnet.aks.id

  upgrade_settings {
    drain_timeout_in_minutes      = 0
    max_surge                     = "10%"
    node_soak_duration_in_minutes = 0
  }
}