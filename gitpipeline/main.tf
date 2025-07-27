resource "azurerm_resource_group" "rg_block" {
  name     = "Ram-rg"
  location = "westus"
}


resource "azurerm_virtual_network" "ram-vnet" {
  name                = "ram-vnet"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  address_space       = ["10.128.0.0/16"]
}






resource "azurerm_subnet" "lavjeet-subnet" {
  name                 = "ram-subnet"
  resource_group_name  = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.ram-vnet.name
  address_prefixes     = ["10.128.1.0/24"]
}


resource "azurerm_public_ip" "lavjeet-pip" {
  name                = "ram-pip"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  allocation_method   = "staticx"
}



resource "azurerm_network_interface" "lavjeet-nic" {
  name                = "ram-nic"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location

  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.lavjeet-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.lavjeet-pip.id
  }
}



resource "azurerm_network_security_group" "lavjeet-nsg" {
  name                = "ram-nsg"
  location            = azurerm_resource_group.rg_block.location
  resource_group_name = azurerm_resource_group.rg_block.name

  security_rule {
    name                       = "terminal"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*" #10.0.0.0/16
    destination_address_prefix = "*"
  }
}


# Associate NSG with Network Interface
resource "azurerm_network_interface_security_group_association" "lavjeet_nic_nsg" {
  network_interface_id      = azurerm_network_interface.lavjeet-nic.id
  network_security_group_id = azurerm_network_security_group.lavjeet-nsg.id
}

resource "azurerm_linux_virtual_machine" "lavjeet-vm" {
  name                            = "lavjeet2-vm"
  resource_group_name             = azurerm_resource_group.rg_block.name
  location                        = azurerm_resource_group.rg_block.location
  size                            = "Standard_F2"
  admin_username                  = "Lavjeet"
  admin_password                  = "Lavjeet@123456789"
  disable_password_authentication = false

 network_interface_ids           = [azurerm_network_interface.lavjeet-nic.id, ]
  # admin_username                  = "adminuser"
  # admin_password                  = "somePassword"

  #  admin_ssh_key {
  #    username   = "adminuser"
  #    public_key = file("~/.ssh/id_rsa.pub")
  #  }

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