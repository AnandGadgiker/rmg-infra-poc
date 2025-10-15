variable "storage_account_name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type    = string
  default = null
}

variable "key_vault_name" {
  type    = string
  default = null
}

variable "user_assigned_identity_id" {
  type    = string
  default = null
}

output "key_vault_key_id" {
  value       = azurerm_key_vault_key.kv_key.id
  description = "The ID of the Key Vault Key for CMK"
}
