terraform {
  required_version = ">= 1.0.0"

  backend "azurerm" {
    resource_group_name  = "rmg-infra"
    storage_account_name = "rmginfrastate"
    container_name       = "tfstate"
    key                  = "terraform.uat.tfstate"
  }
}