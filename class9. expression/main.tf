resource "azurerm_resource_group" "rg_block" {
  name     = var.name
  location = var.location
}


resource "azurerm_storage_account" "stg_block" {
  depends_on               = [azurerm_resource_group.rg_block]
  name                     = "${var.name}stgaccount"
  resource_group_name      = var.name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_virtual_network" "vnet-block" {
  # depends_on          = [azurerm_resource_group.rg_block]
  name                = "${var.name}-vnet2" #each.value.vnet_name
  resource_group_name = var.name
  location            = var.location
  address_space       = var.address_space

# subnet {
#    address_prefixes     = var.address_prefixes
#    name = "subnet1"
# }
}


resource "azurerm_subnet" "subnet" {
  depends_on           = [azurerm_virtual_network.vnet-block]
  name                 = "${var.name}-subnet"
  virtual_network_name = "${var.name}-vnet"
  resource_group_name  = var.name
  address_prefixes     = var.address_prefixes
}



# Public IP
resource "azurerm_public_ip" "public_ip_block" {
  depends_on          = [azurerm_resource_group.rg_block]
  count               = var.enable_pulic_ip ? 1 : 0
  name                = "${var.name}${count.index}-public-ip"
  resource_group_name = var.name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"

}



# Network_Interface_Card
resource "azurerm_network_interface" "nic_block" {
  depends_on          = [azurerm_virtual_network.vnet-block]
  name                = "${var.name}-nic"
  resource_group_name = var.name
  location            = var.location





  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_block[0].id
  }
}


# Network Security Group
resource "azurerm_network_security_group" "nsg_block" {
  depends_on          = [azurerm_network_interface.nic_block]
  name                = "${var.name}-nsg"
  resource_group_name = var.name
  location            = var.location

  security_rule {
    name                       = "ssh"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# NIC association with NSG
resource "azurerm_network_interface_security_group_association" "nic_nsg_block" {
  network_interface_id      = azurerm_network_interface.nic_block.id
  network_security_group_id = azurerm_network_security_group.nsg_block.id
}

#Virtual Machine
resource "azurerm_linux_virtual_machine" "vm_block" {
  depends_on                      = [azurerm_virtual_network.vnet-block]
  name                            = "${var.name}-VM" # we can use same name in VM name field
  resource_group_name             = var.name
  location                        = var.location
  size                            = "Standard_F2"
  admin_username                  = "BholeNath"
  admin_password                  = "BholeNath@123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_block.id]
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

}


output "storage_account_name" {
  description = "The name of the storage account"
  value       = azurerm_storage_account.stg_block.name
}


output "vnet_name" {
  description = "The name of the Virtual Network"
  value       = azurerm_virtual_network.vnet-block.name
}

output "vm_private_ip" {
  description = "The private IP address of the VM"
  value       = azurerm_network_interface.nic_block.private_ip_address
}

