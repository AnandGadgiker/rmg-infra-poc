variable "env" { type = string }

variable "location" { type = string }

variable "resource_group_name" { type = string }

variable "key_vault_name" { type = string }

variable "storage_account_name" { type = string }

variable "app_service_plan_name" { type = string }

variable "app_service_name" { type = string }

variable "subnet_id" { type = string }

variable "cosmosdb_name" { type = string }

variable "acr_name" { type = string }

variable "eventhub_namespace" { type = string }

variable "eventhub_name" { type = string }

variable "aad_client_secret_value" {
  type      = string
  sensitive = true
}

variable "tags" {
  type    = map(string)
  default = {}
}
