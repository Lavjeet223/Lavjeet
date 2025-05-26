# Subnet Data source
data "azurerm_subnet" "data_subnet_block" {
  for_each             = var.bastion
  name                 = "AzureBastionSubnet"
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group_name
}

# Public IP
resource "azurerm_public_ip" "public_ip_block" {
  for_each            = var.bastion
  name                = "${each.value.resource_group_name}-public-ip"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
  sku                 = "Standard"

}

#Azure Bastion Host // similar to NIC Code
resource "azurerm_bastion_host" "bastion_host" {
  for_each            = var.bastion
  name                = "${each.value.resource_group_name}-bastion-host"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  #scale_units         = 2 #default
  ip_configuration {
    name                 = "ipconfig1"
    subnet_id            = data.azurerm_subnet.data_subnet_block[each.key].id
    public_ip_address_id = azurerm_public_ip.public_ip_block[each.key].id
  }

}
