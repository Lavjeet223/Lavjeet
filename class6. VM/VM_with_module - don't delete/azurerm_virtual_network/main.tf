resource "azurerm_virtual_network" "ram-vnet" {
  name                = "ram-vnet"
  resource_group_name = "Ram-rg"
  location            = "westus"
  address_space       = ["10.128.0.0/16"]
}




# resource "azurerm_virtual_network" "lavjeet-vnet" {
#   for_each = var.vnet_map
#   name = each.value.name
#   resource_group_name = each.value.resource_group_name
#   location = each.value.location
#   address_space = each.value.address_space
# }
