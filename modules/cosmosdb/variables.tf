variable "name_prefix" { type = string }
variable "location" { type = string }
variable "resource_group_name" { type = string }
variable "tags" { type = map(string) default = {} }
variable "database_name" { type = string default = "appdb" }
variable "container_name" { type = string default = "appcontainer" }