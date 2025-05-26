# Subnet Data source
data "azurerm_subnet" "data_subnet_block" {
  for_each             = var.vms
  name                 = "${each.value.resource_group_name}-subnet"
  virtual_network_name = "${each.value.resource_group_name}-vnet"
  resource_group_name  = each.value.resource_group_name
}


# Public IP
resource "azurerm_public_ip" "public_ip_block" {
  for_each            = var.vms
  name                = "${each.value.resource_group_name}-public-ip"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = "Static"
  sku                 = "Standard"

}



# Network_Interface_Card
resource "azurerm_network_interface" "nic_block" {
  for_each            = var.vms
  name                = "${each.value.resource_group_name}-nic"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location


  ip_configuration {
    name                          = "ipconfig1"
    subnet_id                     = data.azurerm_subnet.data_subnet_block[each.key].id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip_block[each.key].id
  }
}

# Network Security Group
resource "azurerm_network_security_group" "nsg_block" {
  for_each            = var.vms
  name                = "${each.value.resource_group_name}-nsg"
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

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
  for_each                  = var.vms
  network_interface_id      = azurerm_network_interface.nic_block[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg_block[each.key].id
}

#Virtual Machine
resource "azurerm_linux_virtual_machine" "vm_block" {
  for_each                        = var.vms
  name                            = each.value.resource_group_name # we can use same name in VM name field
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = "BholeNath"
  admin_password                  = "BholeNath@123"
  disable_password_authentication = false
  network_interface_ids           = [azurerm_network_interface.nic_block[each.key].id]
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
