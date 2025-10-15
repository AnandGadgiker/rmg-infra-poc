output "cosmosdb_name" {
  value       = azurerm_cosmosdb_account.cosmosdb.name
  description = "Name of the Cosmos DB account"
}

output "cosmosdb_id" {
  value       = azurerm_cosmosdb_account.cosmosdb.id
  description = "ID of the Cosmos DB account"
}
