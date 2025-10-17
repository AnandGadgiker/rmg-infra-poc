resource "azurerm_eventhub_namespace" "ns" {
  name                     = var.eventhub_namespace
  location                 = var.location
  resource_group_name      = var.resource_group_name
  sku                      = "Standard"
  capacity                 = 1
  auto_inflate_enabled     = true
  maximum_throughput_units = 4
}

resource "azurerm_eventhub" "eh" {
  name                = var.eventhub_name
  resource_group_name = var.resource_group_name
  namespace_name      = azurerm_eventhub_namespace.ns.name
  partition_count     = 2
  message_retention   = 7
}
