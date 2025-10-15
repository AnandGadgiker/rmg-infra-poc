variable "keyvault_id" {
  description = "ID of the Key Vault"
  type        = string
}

variable "cosmosdb_name" {
  description = "Name of the CosmosDB account"
  type        = string
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "eventhub_namespace" {
  description = "EventHub namespace"
  type        = string
}

variable "eventhub_name" {
  description = "EventHub name"
  type        = string
}

variable "app_service_name" {
  description = "Name of the App Service"
  type        = string
}

variable "app_service_default_hostname" {
  description = "Default hostname of the App Service"
  type        = string
}
