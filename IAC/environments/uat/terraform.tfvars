location              = "East US"
resource_group_name   = "uat-rg"
app_service_plan_name = "uat-app-plan"
app_service_name      = "uat-app-service"
app_settings = {
  "ENV" = "uat"
}
cosmosdb_name         = "uat-cosmosdb"
acr_name              = "uatacr"
storage_account_name  = "uatstorageacct"
eventhub_namespace    = "uat-namespace"
eventhub_name         = "uat-hub"