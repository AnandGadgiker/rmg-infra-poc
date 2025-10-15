
terraform {
  required_version = ">= 1.0.0"

terraform {
  backend "azurerm" {
    resource_group_name  = "rmg-infra"
    storage_account_name = "rmginfrastate"
    container_name       = "tfstate"
    key                  = "terraform.dev.tfstate"
  }
}