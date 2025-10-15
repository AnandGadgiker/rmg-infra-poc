variable "location" {}
variable "resource_group_name" {}
variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "app_settings" {
  type = map(string)
}
variable "cosmosdb_name" {}
variable "acr_name" {}
variable "storage_account_name" {}
variable "eventhub_namespace" {}
variable "eventhub_name" {}