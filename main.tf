resource "azurerm_resource_group" "rg_block" {
  name     = var.name
  location = var.location
}

resource "azurerm_virtual_network" "vnet-block" {
  name                = "vnet-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  address_space       = var.address_space
}

resource "azurerm_subnet" "subnet-block" {
  name                 = "subnet1-${var.name}"
  resource_group_name  = var.location
  virtual_network_name = azurerm_virtual_network.vnet-block.name
  address_prefixes     = var.address_prefixes
}

resource "azurerm_public_ip" "public-ip-block" {
  count               = var.enable_public_ip == "Yes" ? 1 : 0
  name                = "public-ip${count.index + 1}-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  allocation_method   = "Static"
}

resource "azurerm_network_interface" "nic-block" {
  name                = "nic-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location

  ip_configuration {
    name                          = "nic1_internal"
    subnet_id                     = azurerm_subnet.subnet-block.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip == "Yes" ? azurerm_public_ip.public-ip-block[0].id : null

  }
}

resource "azurerm_network_security_group" "NSG-block" {
  name                = "nsg-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location

  security_rule {
    name                       = var.VM_type == "Linux" ? "SSh" : "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = var.VM_type == "Linux" ? 22 : 3389
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "NIC-NSG-Association" {
  network_interface_id = azurerm_network_interface.nic-block.id
  network_security_group_id = azurerm_network_security_group.NSG-block.id
}

resource "azurerm_linux_virtual_machine" "linux-vm-block" {
  count                           = var.VM_type == "Linux" ? 1 : 0
  name                            = "${var.name}_vm${count.index + 1}"
  resource_group_name             = azurerm_resource_group.rg_block.name
  location                        = azurerm_resource_group.rg_block.location
  size                            = "Standard_F2"
  admin_username                  = "Bholenath"
  admin_password                  = "Bholenath@123"
  disable_password_authentication = true
  network_interface_ids           = [azurerm_network_interface.nic-block.id]

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

resource "azurerm_windows_virtual_machine" "windows-vm-block" {
  count                 = var.VM_type == "Windows" ? 1 : 0
  name                  = "${var.name}_vm${count.index + 1}"
  resource_group_name   = azurerm_resource_group.rg_block.name
  location              = azurerm_resource_group.rg_block.location
  size                  = "Standard_F2"
  admin_username        = "Bholenath"
  admin_password        = "Bholenath@123"
  network_interface_ids = [azurerm_network_interface.nic-block.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

}
