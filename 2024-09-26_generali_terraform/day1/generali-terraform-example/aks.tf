module "aks--generali-aks-example" {
  source = "./modules/aks"

  name               = "generali-aks-example"
  location           = "northeurope"
  kubernetes_version = "1.28"
  vm_size            = "Standard_B2s"
  node_count         = 1
  tags_common        = local.tags_common
}

module "aks--example" {
  source = "./modules/aks"

  name               = "example"
  location           = "northeurope"
  kubernetes_version = "1.28"
  vm_size            = "Standard_B2s"
  node_count         = 1
  tags_common        = local.tags_common
}

module "foo_aks" {
  source = "git::https://github.com/sika-training-examples/2024-09-26-generali-terraform-modules-example.git//modules/aks"

  name               = "foo"
  location           = "northeurope"
  kubernetes_version = "1.28"
  vm_size            = "Standard_B2s"
  node_count         = 1
  tags_common        = local.tags_common
}
