resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "P1v3"
}

resource "azurerm_linux_web_app" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
    always_on              = true
    ftps_state             = "Disabled"
    vnet_route_all_enabled = true
  }

  app_settings = merge(
    var.app_settings,
    {
      "ENV"               = "dev"
      "AAD_CLIENT_SECRET" = var.aad_client_secret_value
    }
  )
}
