locals {
  prefix = "ondrejsika"

  location               = "westeurope"
  user_node_pool_vm_size = "Standard_B2s"

  resource_group_name = "${local.prefix}-rg-k8s"
  vnet_name           = "${local.prefix}-vnet-aks"
  subnet_name         = "${local.prefix}-subnet-aks"
  law_name            = "${local.prefix}-law-aks"
  aks_name            = "${local.prefix}-aks"
}
