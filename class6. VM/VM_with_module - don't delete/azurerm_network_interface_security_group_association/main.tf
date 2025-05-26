# Associate NSG with Network Interface
resource "azurerm_network_interface_security_group_association" "lavjeet_nic_nsg" {
  network_interface_id      = var.nic_detials
  network_security_group_id = var.nsg_detials
}

variable "nic_detials" {}
variable "nsg_detials" {}
