location = "East US"
resource_group_name = "uat-rg"
app_service_plan_name = "uat-app-plan"
app_service_name = "uat-app-service"
app_settings = {
  "ENV" = "uat"
}
cosmosdb_name = "uat-cosmosdb"
acr_name = "uatacr"
storage_account_name = "uatstorageacct"
eventhub_namespace = "uat-namespace"
eventhub_name = "uat-hub"
subnet_id = "/subscriptions/1caa3d80-14f8-4775-b51b-247372d730b0/resourceGroups/rg-aiforce-hub-uksouth-001/providers/Microsoft.Network/virtualNetworks/vnet-aiforce-rmgpoc-uksouth-001/subnets/sbnt-pep-uksouth-001"