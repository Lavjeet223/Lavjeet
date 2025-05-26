resource "azurerm_subnet" "subnet_block" {
  for_each             = var.vms
  name                 = "${each.value.resource_group_name}-subnet"
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = "${each.value.resource_group_name}-vnet"
  address_prefixes     = each.value.address_prefixes

}
