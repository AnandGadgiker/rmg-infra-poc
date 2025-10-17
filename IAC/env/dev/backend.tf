terraform {
  required_version = ">= 1.5.0"

  backend "azurerm" {
    resource_group_name  = "rmg-infra"
    storage_account_name = "rmginfrastate"
    container_name       = "tfstate"
    key                  = "iac/dev/terraform.tfstate"
  }
}