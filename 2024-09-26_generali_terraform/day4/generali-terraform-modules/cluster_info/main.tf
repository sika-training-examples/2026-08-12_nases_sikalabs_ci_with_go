data "rancher2_cluster" "this" {
  provider = rancher2
  name     = var.cluster_name
}

locals {
  cluster_config_yaml = yamldecode(data.rancher2_cluster.this.kube_config)
}
