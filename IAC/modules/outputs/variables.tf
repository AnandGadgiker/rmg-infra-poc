variable "key_vault_name" {
  type = string
}

variable "cosmosdb_name" {
  type = string
}

variable "acr_name" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "eventhub_namespace" {
  type = string
}

variable "eventhub_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "app_service_default_hostname" {
  type = string
}

output "key_vault_key_id" {
  value       = azurerm_key_vault_key.kv_key.id
  description = "The ID of the Key Vault Key for CMK"
}
