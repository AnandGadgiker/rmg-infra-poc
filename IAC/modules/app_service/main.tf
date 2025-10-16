resource "azurerm_service_plan" "this" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = var.kind
  sku_name            = var.sku_size
}

resource "azurerm_linux_web_app" "this" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_service_plan.this.id

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on  = true
    ftps_state = "Disabled"
    application_stack {
      node_version = "18-lts" # change if you’re using Java, Python, etc.
    }
  }

  app_settings = merge({
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
    "WEBSITES_PORT"                       = "8080"
  }, var.app_settings)
}

# Optional: Private Endpoint (if needed)
resource "azurerm_private_endpoint" "app_pe" {
  count               = var.subnet_id != null ? 1 : 0
  name                = "${var.app_service_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.app_service_name}-priv-conn"
    private_connection_resource_id = azurerm_linux_web_app.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }
}
