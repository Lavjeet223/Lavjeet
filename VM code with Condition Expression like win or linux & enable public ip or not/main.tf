resource "azurerm_resource_group" "rg_block" {
  name     = var.name
  location = var.location
  tags     = merge(local.comman_Tag, local.stg_tag)
}

resource "azurerm_virtual_network" "vnet-block" {
  name                = "vnet-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  address_space       = var.address_space
  tags                = local.comman_Tag
}

resource "azurerm_subnet" "subnet-block" {
  name                 = "subnet1-${var.name}"
  resource_group_name  = azurerm_resource_group.rg_block.name
  virtual_network_name = azurerm_virtual_network.vnet-block.name
  address_prefixes     = var.address_prefixes

}

resource "azurerm_public_ip" "public-ip-block" {
  count               = var.enable_public_ip == "Yes" ? 1 : 0
  name                = "public-ip${count.index + 1}-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  allocation_method   = "Static"
  tags                = local.comman_Tag
}

resource "azurerm_network_interface" "nic-block" {
  name                = "nic-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location
  tags                = local.comman_Tag
  ip_configuration {
    name                          = "nic1_internal"
    subnet_id                     = azurerm_subnet.subnet-block.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.enable_public_ip == "Yes" ? azurerm_public_ip.public-ip-block[0].id : null

  }
}

resource "azurerm_network_security_group" "NSG-block" {
  depends_on          = [azurerm_network_interface.nic-block]
  name                = "nsg-${var.name}"
  resource_group_name = azurerm_resource_group.rg_block.name
  location            = azurerm_resource_group.rg_block.location

  security_rule {
    name                       = var.VM_type == "Linux" ? "SSH" : "RDP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = var.VM_type == "Linux" ? "22" : "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  # Additional Rule for Nginx port open
  security_rule {
    name                       = "HTTP"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


}

resource "azurerm_network_interface_security_group_association" "NIC-NSG-Association" {
  network_interface_id      = azurerm_network_interface.nic-block.id
  network_security_group_id = azurerm_network_security_group.NSG-block.id
}

resource "azurerm_linux_virtual_machine" "linux-vm-block" {
  depends_on                      = [azurerm_network_security_group.NSG-block]
  count                           = var.VM_type == "Linux" ? 1 : 0
  name                            = "${var.name}${count.index + 1}"
  resource_group_name             = azurerm_resource_group.rg_block.name
  location                        = azurerm_resource_group.rg_block.location
  size                            = "Standard_F2"
  admin_username                  = "Bholenath"
  admin_password                  = "Bholenath@123"
  disable_password_authentication = false
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

  # provisioner "remote-exec" {


  #   inline = [
  #     "sudo apt update",
  #     "sudo apt install nginx -y"
  #   ]
  #   connection {
  #     type     = "ssh"
  #     user     = "Bholenath"
  #     password = "Bholenath@123"
  #     host     = var.enable_public_ip == "Yes" ? azurerm_public_ip.public-ip-block[0].ip_address : null
  #   }

  # }
  tags = merge(local.comman_Tag, local.stg_tag)
}

resource "azurerm_windows_virtual_machine" "windows-vm-block" {
  depends_on            = [azurerm_network_security_group.NSG-block]
  count                 = var.VM_type == "Windows" ? 1 : 0
  name                  = "${var.name}${count.index + 1}"
  resource_group_name   = azurerm_resource_group.rg_block.name
  location              = azurerm_resource_group.rg_block.location
  size                  = "Standard_F2"
  admin_username        = "Bholenath"
  admin_password        = "Bholenath@123"
  network_interface_ids = [azurerm_network_interface.nic-block.id]
  tags                  = merge(local.comman_Tag, local.stg_tag)
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

  provisioner "local-exec" {
    command = "echo ${self.name} created!"
  }

}

output "public_ip" {
  value       = var.enable_public_ip == "Yes" ? azurerm_public_ip.public-ip-block[0].ip_address : "No Public IP"
  description = "Public IP of the VM"
}

resource "null_resource" "remote_setup" {
  count = var.enable_public_ip == "Yes" && var.VM_type == "Linux" ? 1 : 0

  provisioner "remote-exec" {
    inline = [
      "sudo apt update",
      "sudo apt install nginx -y"
    ]

    connection {
      type     = "ssh"
      host     = var.enable_public_ip== "Yes" ? azurerm_public_ip.public-ip-block[0].ip_address : null
      user     = "Bholenath"
      password = "Bholenath@123"
    }
  }

  # Optional: trigger re-run when VM name changes
  triggers = {
    vm_name = azurerm_linux_virtual_machine.linux-vm-block[0].name
  }
}
