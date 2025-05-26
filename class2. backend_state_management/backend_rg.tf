resource "azurerm_resource_group" "lavbackendrgblock" {
  name     = "lavbackendrg"
  location = "westus"

}

resource "azurerm_storage_account" "lavbackendstgblock" {
  name                     = "lavbackendstg"
  resource_group_name      = azurerm_resource_group.lavbackendrgblock.name
  location                 = "westus"
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "lavbackendcontblock" {
  name                  = "lavbackendcont"
  storage_account_id    = azurerm_storage_account.lavbackendstgblock.id
  container_access_type = "private"

}

