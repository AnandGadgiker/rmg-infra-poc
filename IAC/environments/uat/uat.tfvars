# Azure region and resource group
location              = "East US 2"
resource_group_name   = "uat-rg"

# App Service
app_service_plan_name = "uat-app-plan"
app_service_name      = "uat-app-service"
app_service_plan_id   = "replace-with-uat-app-plan-id"

# Application settings (secrets are retrieved dynamically)
app_settings = {
  ENV = "uat"
}

# Cosmos DB
cosmosdb_name = "uat-cosmosdb"

# ACR
acr_name = "uatacr"

# Storage Account
storage_account_name = "uatstorageacct"

# Event Hub
eventhub_namespace = "uat-namespace"
eventhub_name      = "uat-hub"

# Subnet
subnet_id = "/subscriptions/1caa3d80-14f8-4775-b51b-247372d730b0/resourceGroups/rg-aiforce-hub-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-aiforce-rmgpoc-uksouth-001/subnets/sbnt-pep-uksouth-001"

# Key Vault
key_vault_name = "kv-uat-rmg"
