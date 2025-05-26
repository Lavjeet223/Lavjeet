resource "azurerm_network_interface" "lavjeet-nic" {
  name                = "ram-nic"
  resource_group_name = "Ram-rg"
  location            = "westus"

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = var.subnetid
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_id
  }
}


variable "subnetid" {}
variable "public_id" {}
