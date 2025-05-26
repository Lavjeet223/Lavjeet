# Resource Block Data
# data "azurerm_resource_group" "data_rg" {
#   for_each = var.rg
#   name = each.value.resource_group_name
# }


# Public IP for Loadbalancer
resource "azurerm_public_ip" "public_ip_lb" {
  name                = "Radhakrishan-lb-public_ip"
  resource_group_name = "Radhakrishan"
  location            = "southindia"
  allocation_method   = "Static"

}



# loadbalancer Frontend Configuration

resource "azurerm_lb" "loadbalancer" {
  name                = "Radhakrishan-frontend-lb"
  resource_group_name = "Radhakrishan"
  location            = "southindia"
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "frontend"
    public_ip_address_id = azurerm_public_ip.public_ip_lb.id

  }
}


# Backend Pools Configuration

resource "azurerm_lb_backend_address_pool" "lb_backend_pools" {
  name            = "Radhakrishan-backendpools-lb"
  loadbalancer_id = azurerm_lb.loadbalancer.id


}

data "azurerm_network_interface" "data-nic" {
  for_each            = var.vms
  name                = "${each.value.vm_name}-nic"
  resource_group_name = "Radhakrishan"
}

# Associate Each VM’s NIC with Backend Pool

resource "azurerm_network_interface_backend_address_pool_association" "backend_pool_nic" {
 for_each = var.vms
  ip_configuration_name   = "ipconfig1"
  network_interface_id    = data.azurerm_network_interface.data-nic[each.key].id
  backend_address_pool_id = azurerm_lb_backend_address_pool.lb_backend_pools.id
}


# Health Probe 

resource "azurerm_lb_probe" "health_probe" {
  name            = "Radhakrishan-Health-probe"
  loadbalancer_id = azurerm_lb.loadbalancer.id
  port            = 80
}



# loadbalancing Rules

resource "azurerm_lb_rule" "loadbalancing_rules" {
  name                           = "Radhakrishan-LB-rules"
  loadbalancer_id                = azurerm_lb.loadbalancer.id
  frontend_ip_configuration_name = "frontend"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 80


}
