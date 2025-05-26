
resource "azurerm_subnet" "lavjeet-subnet" {
  name                 = "ram-subnet"
  resource_group_name  = "Ram-rg"
  virtual_network_name = "ram-vnet"
  address_prefixes     = ["10.128.1.0/24"]
}








# resource "azurerm_subnet" "lavjeet-subet" {
#   for_each = var.subnet_map
#   name = each.value.name
#   resource_group_name = each.value.resource_group_name
#   virtual_network_name = each.value.virtual_network_name
#   address_prefixes = each.value.address_prefixes
# }
