variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "app_settings" {
  type = map(string)
}
variable "subnet_id" {}

resource "azurerm_app_service_plan" "plan" {
  name                = var.app_service_plan_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = var.app_service_name
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    scm_type = "LocalGit"
    vnet_route_all_enabled = true
  }

  app_settings = var.app_settings
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  app_service_id = azurerm_app_service.app.id
  subnet_id      = var.subnet_id
}