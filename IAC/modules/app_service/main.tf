# App Service Plan
resource "azurerm_app_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "P1v2"
    size = "P1v2"
  }

  # Optional: if subnet_id is provided, use ASE v3
  dynamic "reserved" {
    for_each = var.subnet_id != null ? [1] : []
    content {
      value = true
    }
  }
}

# App Service
resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  app_settings = var.app_settings
  
}

# Outputs
output "app_service_name" {
  value = azurerm_app_service.app.name
}

output "default_hostname" {
  value = azurerm_app_service.app.default_site_hostname
}
