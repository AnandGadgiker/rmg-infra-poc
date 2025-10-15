variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "app_service_plan_name" {
  type = string
}

variable "app_service_name" {
  type = string
}

variable "app_settings" {
  type = map(string)
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

variable "subnet_id" {
  type = string
}

variable "key_vault_name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure Active Directory tenant ID"
  type        = string
}

variable "object_id" {
  description = "Object ID for access policy"
  type        = string
}

variable "app_service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "key_vault_key_id" {
  description = "Key Vault key ID for CMK encryption"
  type        = string
}
