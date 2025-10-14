variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "sku" { type = string default = "Standard" }

resource "azurerm_container_registry" "acr" {
  name                = "${var.name_prefix}acr"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  admin_enabled       = false
  tags                = var.tags
}

output "acr_login_server" { value = azurerm_container_registry.acr.login_server }
output "acr_name" { value = azurerm_container_registry.acr.name }
