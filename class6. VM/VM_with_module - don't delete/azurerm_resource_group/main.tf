resource "azurerm_resource_group" "lavjeetrg" {
  name     = "Ram-rg"
  location = "westus"
}





# resource "azurerm_resource_group" "lavjeetrg1" {
#   for_each = var.rg_map
#   name     = each.key
#   location = each.value
# }


