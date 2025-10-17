resource "azurerm_cosmosdb_account" "cosmos" {
  name                = var.cosmosdb_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level       = "Session"
    max_interval_in_seconds = 5
    max_staleness_prefix    = 100
  }

  enable_automatic_failover = false

  capabilities {
    name = "EnableServerless"
  }

  default_identity_type = "SystemAssigned"

  customer_managed_key {
    key_vault_key_id = var.key_vault_key_id
  }
}
