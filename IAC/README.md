IAC/
├── README.md
├── modules/
│   ├── acr/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── app_service/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── cosmosdb/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── eventhub/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── keyvault/
│   │   ├── main.tf
│   │   └── variables.tf
│   ├── outputs/
│   │   ├── main.tf
│   │   └── variables.tf
│   └── storage_account/
│       ├── main.tf
│       └── variables.tf
├── environments/
│   ├── dev/
│   │   ├── backend.tf
│   │   ├── providers.tf
│   │   ├── main.tf           # includes keyvault, app service plan, app service, cosmosdb, acr, storage, eventhub, outputs
│   │   ├── variables.tf
│   │   └── terraform.tfvars  # fully automated, no app_service_plan_id
│   └── uat/
│       ├── backend.tf
│       ├── providers.tf
│       ├── main.tf           # same as dev but ENV = "uat"
│       ├── variables.tf
│       └── terraform.tfvars  # fully automated, no app_service_plan_id
