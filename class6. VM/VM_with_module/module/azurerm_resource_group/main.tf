resource "azurerm_resource_group" "rg_block" {
  for_each = var.vms
  name     = each.value.resource_group_name
  location = each.value.location
}
