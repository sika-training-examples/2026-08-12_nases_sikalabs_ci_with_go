# Step 5: kubeconfig output
output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
}

output "law_id" {
  value = azurerm_log_analytics_workspace.law.id
}
