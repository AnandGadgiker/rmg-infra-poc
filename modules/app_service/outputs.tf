output "app_service_ids" { value = azurerm_linux_web_app.apps[*].id }
output "app_service_names" { value = azurerm_linux_web_app.apps[*].name }
output "app_service_plan_id" { value = azurerm_app_service_plan.asp.id }