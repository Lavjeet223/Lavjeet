resource "azurerm_resource_group" "LavRG1" {
  name     = "lavjeet1"
  location = "west US"
}

resource "azurerm_resource_group" "LavRG2" {
  name     = "lavjeet2"
  location = "west US"
}


resource "azurerm_storage_account" "LavjeetStorage1" {
  depends_on               = [azurerm_resource_group.LavRG1] # this is k/a Explicit dependency , also k/a block level dependency. [<resource_type>.<Blockname>]
  name                     = "lavjeetstorage1"
  resource_group_name      = "lavjeet1"
  location                 = "west Europe"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_account" "LavjeetStorage2" {
  name                     = "lavjeetstorage2"
  resource_group_name      = azurerm_resource_group.LavRG2.name ## Implicit dependency. 
  location                 = "central india"
  account_tier             = "Standard"
  account_replication_type = "GRS"
}



resource "azurerm_storage_container" "lavcont1" {
  name                  = "lavjeetcont1"
  storage_account_id    = azurerm_storage_account.LavjeetStorage1.id ## Implicit dependency. 
  container_access_type = "private"
}

resource "azurerm_storage_container" "lavcont2" {
  name                  = "lavjeetcont1"  # we are giving same name for container b/c its in different stg a/c
  storage_account_id    = azurerm_storage_account.LavjeetStorage2.id # Implicit dependency. 
  container_access_type = "private"
}