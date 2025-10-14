variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "database_name" { type = string default = "appdb" }
variable "container_name" { type = string default = "appcontainer" }

resource "azurerm_cosmosdb_account" "this" {
  name                = "${var.name_prefix}-cdb"
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  consistency_policy {
    consistency_level = "Session"
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }

  capabilities = [{ name = "EnableServerless" }]

  tags = var.tags
}

resource "azurerm_cosmosdb_sql_database" "db" {
  name                = var.database_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
}

resource "azurerm_cosmosdb_sql_container" "container" {
  name                = var.container_name
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.this.name
  database_name       = azurerm_cosmosdb_sql_database.db.name

  partition_key_path = "/id"
  throughput         = 400
}

output "cosmosdb_account_endpoint" { value = azurerm_cosmosdb_account.this.endpoint }
output "cosmosdb_account_name" { value = azurerm_cosmosdb_account.this.name }
