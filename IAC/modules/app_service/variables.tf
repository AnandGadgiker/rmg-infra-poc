##############################
# App Service Variables
##############################

variable "app_service_plan_name" {
  description = "Name of the App Service Plan"
  type        = string
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the private endpoint (optional)"
  type        = string
  default     = null
}

variable "kind" {
  description = "Specifies the kind of the App Service (Linux or Windows)"
  type        = string
  default     = "Linux"
}

variable "sku_tier" {
  description = "App Service Plan tier (e.g., P1v3)"
  type        = string
  default     = "P1v3"
}

variable "sku_size" {
  description = "App Service Plan size (e.g., P1v3)"
  type        = string
  default     = "P1v3"
}

variable "app_settings" {
  description = "Custom application settings for the App Service"
  type        = map(string)
  default     = {}
}

variable "storage_account_name" {
  description = "Optional storage account name for the App Service"
  type        = string
  default     = null
}

variable "key_vault_name" {
  description = "Optional Key Vault name for injecting secrets"
  type        = string
  default     = null
}

variable "key_vault_key_id" {
  description = "Optional Key Vault key for CMK encryption"
  type        = string
  default     = null
}

variable "aad_client_secret_value" {
  description = "AAD client secret value injected into App Service"
  type        = string
  sensitive   = true
  default     = null
}
