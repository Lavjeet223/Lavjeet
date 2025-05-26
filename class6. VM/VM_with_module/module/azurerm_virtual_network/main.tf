resource "azurerm_virtual_network" "vnet-block" {
  for_each            = var.vms
  name                = "${each.value.resource_group_name}-vnet" #each.value.vnet_name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  address_space       = each.value.address_space

}
