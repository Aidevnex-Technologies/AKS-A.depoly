output "aks_name" {
  value = azurerm_kubernetes_cluster.aks_cluster.name
}

output "aks_name_kubelet_identity" {
  value = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity
}

output "acr_id" {
  value = data.azurerm_container_registry.acr.id
}

output "subnet_name" {
  value = var.snet_name
}

output "vnet_name" {
  value = var.vnet_name
}
