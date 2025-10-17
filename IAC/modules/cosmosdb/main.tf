resource "azurerm_cosmosdb_account" "cosmos" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  # Required consistency policy
  consistency_policy {
    consistency_level = "Session"
  }

  # At least one geo_location block is mandatory
  geo_location {
    location          = var.location
    failover_priority = 0
  }

  # Enable managed identity so Cosmos can use CMK
  identity {
    type = "SystemAssigned"
  }

  # Customer Managed Key (CMK) binding
  key_vault_key_id = var.key_vault_key_id

  tags = {
    Env = "cosmos-${var.env}"
  }
}
