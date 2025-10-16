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

variable "env" {
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

variable "subnet_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "key_vault_name" {
  type = string
}

variable "terraform_sp_object_id" {
  type        = string
  description = "Object ID of the SP or Managed Identity running Terraform"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign resources"
}

variable "env" {
  type = string
}

