resource "azurerm_storage_account" "lavjeetstg" {
  name                     = "lavjeetstgmodule"
  resource_group_name      = "Ram-rg"
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}



# resource "azurerm_storage_account" "lavjeetstg1" {
#   for_each                 = var.stg_map
#   name                     = each.value.name
#   resource_group_name      = each.value.resource_group_name
#   location                 = each.value.location
#   account_tier             = each.value.account_tier
#   account_replication_type = each.value.account_replication_type
# }