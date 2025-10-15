output "app_service_name" {
  value       = azurerm_app_service.app.name
  description = "Name of the Azure App Service"
}

output "app_service_id" {
  value       = azurerm_app_service.app.id
  description = "ID of the Azure App Service"
}

output "app_service_default_hostname" {
  value       = azurerm_app_service.app.default_site_hostname
  description = "Default hostname of the App Service"
}

output "app_service_identity_principal_id" {
  value       = azurerm_app_service.app.identity[0].principal_id
  description = "Principal ID of the system-assigned managed identity"
}
