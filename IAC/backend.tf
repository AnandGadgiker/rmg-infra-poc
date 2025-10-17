terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "rmginfrastate"
    container_name       = "tfstate"
    key                  = "iac/dev/terraform.tfstate"
  }
}
