output "kubernetes_host" {
  value = local.cluster_config_yaml["clusters"][0]["cluster"]["server"]
}

output "kubernetes_token" {
  value = local.cluster_config_yaml["users"][0]["user"]["token"]
}

output "cluster_id" {
  value = data.rancher2_cluster.this.id
}

output "cluster" {
  value     = data.rancher2_cluster.this
  sensitive = true
}
