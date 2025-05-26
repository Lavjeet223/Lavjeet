########## Set variable code
resource "azurerm_resource_group" "rgset_block" {
  for_each = var.rg_set_block_details
  name     = each.value
  location = "centralindia"

}


########## list  variable code
resource "azurerm_resource_group" "rglist_block" {
  for_each = toset(var.rg_list_block_details)
  name     = each.value
  location = "southindia"

}



########## map variable code
resource "azurerm_resource_group" "rgmap_block" {
  for_each = var.rg_map_block_details
  name     = each.value.name
  location = each.value.location

}



########## map advance variable code for rg block
resource "azurerm_resource_group" "rgmap_advance_block" {
  for_each = var.rg_map_advance_block_details
  name     = each.key
  location = each.value

}



########## map advance variable code for stg block
resource "azurerm_storage_account" "mapstg_block" {
  depends_on               = [azurerm_resource_group.rgmap_advance_block]
  for_each                 = var.stg_map_advance_block_detials # ye for_each kitni bar chalega .. ans jitni bas isme key hai 18 bar ( 3 badi key and 5-5-5 value ke andar keys)
  name                     = each.value.name ### we can also pass key value  each.key this time it will pick value as lavmapadvancestg1key lavmapadvancestg2key lavmapadvancestg3key
  resource_group_name      = each.value.resource_group_name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

}
