variable "app_service_plan_name" { type = string }
variable "app_service_name" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "subnet_id" { type = string }      # optional, if needed
variable "app_settings" { type = map(string) }
