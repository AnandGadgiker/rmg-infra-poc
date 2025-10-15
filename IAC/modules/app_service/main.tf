##############################
# App Service Resource
##############################
resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = var.app_service_plan_id
  kind                = "Linux"

  site_config {
    linux_fx_version = var.linux_fx_version
  }

  app_settings = var.app_settings

  identity {
    type = "SystemAssigned"
  }

  depends_on = [var.depends_on] # optional, if you want explicit dependencies
}
