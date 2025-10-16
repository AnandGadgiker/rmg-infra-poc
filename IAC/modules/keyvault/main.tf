# 1️⃣ Key Vault
resource "azurerm_key_vault" "kv" {
  name                     = var.key_vault_name
  location                 = var.location
  resource_group_name      = var.resource_group_name
  tenant_id                = var.tenant_id
  sku_name                 = "standard"
  purge_protection_enabled = true

  tags = merge(
    var.tags,
    {
      Owner       = "rmg-devops"
      Environment = var.env
    }
  )
}

# 2️⃣ Access Policy for Terraform SP (required to create keys)
resource "azurerm_key_vault_access_policy" "terraform_sp" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = var.tenant_id
  object_id    = var.terraform_sp_object_id

  key_permissions = [
    "Get", "List", "Create", "Update", "Delete", "Recover", "Backup", "Restore", "Encrypt", "Decrypt", "Sign", "Verify"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete", "Recover", "Backup", "Restore"
  ]
}

# 3️⃣ Optional: wait for policy propagation
resource "null_resource" "wait_for_policy" {
  provisioner "local-exec" {
    command = "sleep ${var.policy_propagation_delay}"
  }

  depends_on = [azurerm_key_vault_access_policy.terraform_sp]
}

# 4️⃣ Customer Managed Key (CMK)
resource "azurerm_key_vault_key" "cmk" {
  name         = "cmk-key"
  key_vault_id = azurerm_key_vault.kv.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["encrypt", "decrypt"]

  depends_on = [null_resource.wait_for_policy]
}

# 5️⃣ Outputs
output "key_vault_key_id" {
  value = azurerm_key_vault_key.cmk.id
}
