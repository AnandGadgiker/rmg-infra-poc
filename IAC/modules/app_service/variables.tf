variable "app_service_plan_name" {}
variable "app_service_name" {}
variable "location" {}
variable "resource_group_name" {}
variable "app_settings" {
  type = map(string)
}
variable "subnet_id" {}