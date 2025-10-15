terraform-azure-project/
├── backend.tf
├── providers.tf
├── README.md
├── modules/
│   ├── acr/
│   ├── app_service/
│   ├── cosmosdb/
│   ├── eventhub/
│   └── storage_account/
├── environments/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   └── uat/
│       ├── main.tf
│       ├── variables.tf
│       └── terraform.tfvars