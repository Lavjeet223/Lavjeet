resource "azurerm_network_security_group" "lavjeet-nsg" {
  name                = "ram-nsg"
  location            = "westus"
  resource_group_name = "Ram-rg"

  security_rule {
    name                       = "terminal"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}