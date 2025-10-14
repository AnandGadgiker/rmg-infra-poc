variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "eventhub_name" { type = string default = "events" }

resource "azurerm_eventhub_namespace" "ns" {
  name                = "${var.name_prefix}-ehns"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  capacity            = 1
  tags                = var.tags
}

resource "azurerm_eventhub" "eh" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.ns.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}

output "eventhub_namespace_name" { value = azurerm_eventhub_namespace.ns.name }
output "eventhub_name" { value = azurerm_eventhub.eh.name }
