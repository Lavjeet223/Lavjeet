resource "azurerm_resource_group" "lavjeetrg1" {
  for_each = var.rg_map
  name     = each.value.name
  location = each.value.location
}


