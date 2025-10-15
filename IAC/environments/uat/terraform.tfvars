location              = "East US"
resource_group_name   = "uat-rg"
app_service_plan_name = "uat-app-plan"
app_service_name      = "uat-app-service"

app_settings = {
  "ENV"               = "uat"
  "AAD_CLIENT_SECRET" = "replace-with-key-vault-secret-name" # Used in auth_settings_v2
}

cosmosdb_name         = "uat-cosmosdb"
acr_name              = "uatacr"
storage_account_name  = "uatstorageacct"
eventhub_namespace    = "uat-namespace"
eventhub_name         = "uat-hub"
subnet_id             = "/subscriptions/1caa3d80-14f8-4775-b51b-247372d730b0/resourceGroups/rg-aiforce-hub-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-aiforce-rmgpoc-uksouth-001/subnets/sbnt-pep-uksouth-001"

#  Azure AD Authentication
auth_client_id     = "replace-with-your-client-id"
auth_client_secret = "replace-with-your-client-secret"
auth_issuer_url    = "https://sts.windows.net/189de737-c93a-4f5a-8b68-6f4ca9941912/"

# Storage Mount
storage_account_access_key = "replace-with-access-key"
storage_share_name         = "replace-with-share-name"