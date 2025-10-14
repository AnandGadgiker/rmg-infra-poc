variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "sku" { type = string default = "P1v2" }
variable "app_count" { type = number default = 2 }
variable "subnet_id" { type = string default = "" }

resource "azurerm_app_service_plan" "asp" {
  name                = "${var.name_prefix}-asp"
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "Linux"

  sku {
    tier = "PremiumV2"
    size = var.sku
  }

  reserved = true
  tags     = var.tags
}

resource "azurerm_linux_web_app" "apps" {
  count               = var.app_count
  name                = "${var.name_prefix}-app-${count.index + 1}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id     = azurerm_app_service_plan.asp.id

  site_config {
    linux_fx_version = "NODE|16"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  tags = var.tags
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_conn" {
  count = length(trim(var.subnet_id)) > 0 ? var.app_count : 0

  app_service_id = azurerm_linux_web_app.apps[count.index].id
  subnet_id      = var.subnet_id
}

output "app_service_ids" { value = azurerm_linux_web_app.apps[*].id }
output "app_service_names" { value = azurerm_linux_web_app.apps[*].name }
output "app_service_plan_id" { value = azurerm_app_service_plan.asp.id }
