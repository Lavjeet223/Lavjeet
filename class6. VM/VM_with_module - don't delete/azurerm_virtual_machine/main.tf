#variable "nic_id" {}
variable "nic_detials" {}

resource "azurerm_linux_virtual_machine" "lavjeet-vm" {
  name                            = "Ram-vm"
  resource_group_name             = "Ram-rg"
  location                        = "westus"
  size                            = "Standard_F2"
  admin_username                  = "Lavjeet"
  admin_password                  = "Lavjeet@123456789"
  network_interface_ids           = [var.nic_detials]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}



# # resource "azurerm_windows_virtual_machine" "lavjeet-vm" {
# #   name                = "ram-vm"
# #   resource_group_name = azurerm_resource_group.rg_block.name
# #   location            = azurerm_resource_group.rg_block.location
# #   size                = "Standard_F2"
# #   admin_username      = "Lavjeet"
# #   admin_password      = "Lavjeet@123456789"
# #   network_interface_ids = [azurerm_network_interface.lavjeet-nic.id] #list(sting)

# #   os_disk {
# #     caching              = "ReadWrite"
# #     storage_account_type = "Standard_LRS"
# #   }

# #   source_image_reference {
# #     publisher = "MicrosoftWindowsServer"
# #     offer     = "WindowsServer"
# #     sku       = "2016-Datacenter"
# #     version   = "latest"
# #   }
# # }
