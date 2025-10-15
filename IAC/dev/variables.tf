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
  type = string
}

variable "tenant_id" {
  type = string
}
