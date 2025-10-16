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

  depends_on = [azurerm_eventhub_namespace.namespace]
}

resource "azurerm_private_endpoint" "eventhub_pe" {
  name                = "${var.eventhub_name}-pe"
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = "${var.eventhub_name}-psc"
    private_connection_resource_id = azurerm_eventhub_namespace.namespace.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  depends_on = [azurerm_eventhub_namespace.namespace]
}