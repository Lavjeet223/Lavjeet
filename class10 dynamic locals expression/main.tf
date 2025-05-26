variable "ip_for_storage_account" {}


locals {
  comman_tags = {
    environment = "Production"
    cost_center = "lavjeet_cost"
    app_id      = "test_app"
  }
  rg_specific_tag = {
    company    = "Nokia"
    department = "cns"
  }
  name     = "rajeev"
  location = "southindia"
}


resource "azurerm_resource_group" "rg-block" {
  name     = local.name
  location = local.location
  tags     = merge(local.comman_tags, local.rg_specific_tag)
}

resource "azurerm_virtual_network" "vnet-block" {
  name                = "vnet-${local.name}"
  address_space       = ["10.0.0.0/16"]
  location            = local.location
  resource_group_name = azurerm_resource_group.rg-block.name

}

resource "azurerm_subnet" "subnet-block" {
  name                 = "subnet-${local.name}"
  resource_group_name  = local.name
  virtual_network_name = azurerm_virtual_network.vnet-block.name
  address_prefixes     = ["10.0.2.0/24"]
  service_endpoints    = ["Microsoft.Storage"]
}



resource "azurerm_storage_account" "stg-block" {
  name                     = "stgacount${local.name}"
  resource_group_name      = azurerm_resource_group.rg-block.name
  location                 = azurerm_resource_group.rg-block.location
  account_tier             = "Standard"
  account_replication_type = "LRS"


  dynamic "network_rules" {
    ## solution 1
    ##for_each will work with map variable and utni bar chalega jitni kyes hongi.
    ## ab yhan {} isme key 0 hai to nhi chalge & {key = "anything"} yhan key 1 hai to ek bar chalega

    #for_each = var.ip_for_storage_account == null ? {} : { key = 1 } 



    ## Solution 2
    ##for_each list aur set ke sath  b kam krta ha na now 
    ##this is with set variable and ab yhan [] isme kuch ni hai set krne ko to ni chalgea  &  
    ## [anynumber/"anythingStingg"] yhan 1 bar chalgea qkyuki hum ek value set kr rhe hai 

    for_each = var.ip_for_storage_account == null ? [] : [1]

    content {
      default_action             = "Deny"
      ip_rules                   = var.ip_for_storage_account
      virtual_network_subnet_ids = [azurerm_subnet.subnet-block.id]
    }
  }

  tags = local.comman_tags
}
