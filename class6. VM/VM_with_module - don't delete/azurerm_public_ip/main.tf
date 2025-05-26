resource "azurerm_public_ip" "lavjeet-pip" {
  name                = "ram-pip"
  resource_group_name = "Ram-rg"
  location            = "westus"
  allocation_method   = "Static"
}


# resource "azurerm_public_ip" "lavjeet-public-ip" {
#   for_each = var.public_ip_map
#   name = each.value.name
#   resource_group_name = each.value.resource_group_name
#   location = each.value.location
#   allocation_method = each.value.allocation_method
# }
