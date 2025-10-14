variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "sku" { type = string default = "P1v2" }
variable "app_count" { type = number default = 2 }
variable "subnet_id" { type = string default = "" }