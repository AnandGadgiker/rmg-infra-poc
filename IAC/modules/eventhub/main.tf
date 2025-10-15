resource "azurerm_eventhub_namespace" "namespace" {
  name                = var.eventhub_namespace
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
}

resource "azurerm_eventhub" "hub" {
  name                = var.eventhub_name
  namespace_name      = azurerm_eventhub_namespace.namespace.name
  resource_group_name = var.resource_group_name
  partition_count     = 2
  message_retention   = 1
}
