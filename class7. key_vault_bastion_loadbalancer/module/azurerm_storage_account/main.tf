resource "azurerm_storage_account" "stg_block" {
  for_each                 = var.rg
  name                     = "${each.value.resource_group_name}stgacount"
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
