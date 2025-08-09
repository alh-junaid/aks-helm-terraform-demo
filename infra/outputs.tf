output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}
output "aks_cluster_name" {
  description = "Name of the created AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}
output "aks_cluster_id" {
  description = "ID of the created AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}
output "kube_config" {
  description = "Kubernetes config to access the cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}