output "acr_name" {
  value       = azurerm_container_registry.acr.name
  description = "Name of the Azure Container Registry"
}

output "acr_id" {
  value       = azurerm_container_registry.acr.id
  description = "ID of the Azure Container Registry"
}
