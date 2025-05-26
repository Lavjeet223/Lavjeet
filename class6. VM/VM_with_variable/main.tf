# resource "azurerm_resource_group" "lavjeet-rg" {
#   for_each = var.vms
#   name     = each.value.resource_group_name
#   location = each.value.location
# }


# resource "azurerm_virtual_network" "lavjeet-vnet" {
#   for_each            = var.vms
#   name                = each.value.vnet_name
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location
#   address_space       = each.value.address_space
# }



# resource "azurerm_subnet" "lavjeet-subnet" {
#   for_each             = var.vms
#   name                 = each.value.subnet_name
#   resource_group_name  = each.value.resource_group_name
#   virtual_network_name = each.value.vnet_name
#   address_prefixes     = each.value.address_prefixes
# }


# resource "azurerm_public_ip" "lavjeet-pip" {
#   for_each            = var.vms
#   name                = each.value.public_ip_name
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location
#   allocation_method   = "Static"
# }



# resource "azurerm_network_interface" "lavjeet-nic" {
#   for_each            = var.vms
#   name                = each.value.nic_name
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location

#   ip_configuration {
#     name                          = "ipconfig1"
#     subnet_id                     = azurerm_subnet.lavjeet-subnet[each.key].id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id          = azurerm_public_ip.lavjeet-pip[each.key].id
#   }
# }



# resource "azurerm_network_security_group" "lavjeet-nsg" {
#   for_each            = var.vms
#   name                = each.value.nsg_name
#   resource_group_name = each.value.resource_group_name
#   location            = each.value.location

#   security_rule {
#     name                       = "SSH_RDP"
#     priority                   = 100
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "*"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }


# # Associate NSG with Network Interface
# resource "azurerm_network_interface_security_group_association" "lavjeet_nic_nsg" {
#   for_each                  = var.vms
#   network_interface_id      = azurerm_network_interface.lavjeet-nic[each.key].id
#   network_security_group_id = azurerm_network_security_group.lavjeet-nsg[each.key].id
# }

# resource "azurerm_linux_virtual_machine" "lavjeet-vm" {
#   for_each                        = var.vms
#   name                            = each.value.vm_name
#   resource_group_name             = each.value.resource_group_name
#   location                        = each.value.location
#   size                            = each.value.size
#   admin_username                  = "Lavjeet"
#   admin_password                  = "Lavjeet@123456789"
#   network_interface_ids           = [azurerm_network_interface.lavjeet-nic[each.key].id, ]
#   disable_password_authentication = false

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }
#   source_image_reference {
#     publisher = "Canonical"
#     offer     = "0001-com-ubuntu-server-jammy"
#     sku       = "22_04-lts"
#     version   = "latest"
#   }

# }




# # # resource "azurerm_windows_virtual_machine" "lavjeet-vm" {
# # #   name                = "ram-vm"
# # #   resource_group_name = azurerm_resource_group.rg_block.name
# # #   location            = azurerm_resource_group.rg_block.location
# # #   size                = "Standard_F2"
# # #   admin_username      = "Lavjeet"
# # #   admin_password      = "Lavjeet@123456789"
# # #   network_interface_ids = [azurerm_network_interface.lavjeet-nic.id] #list(sting)

# # #   os_disk {
# # #     caching              = "ReadWrite"
# # #     storage_account_type = "Standard_LRS"
# # #   }

# # #   source_image_reference {
# # #     publisher = "MicrosoftWindowsServer"
# # #     offer     = "WindowsServer"
# # #     sku       = "2016-Datacenter"
# # #     version   = "latest"
# # #   }
# # # }
