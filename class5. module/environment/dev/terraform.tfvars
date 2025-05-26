rg_details = {
  rg1 = {
    name     = "lavjeetrg1"
    location = "westus"
  }

  rg2 = {
    name     = "lavjeetrg2"
    location = "centralindia"
  }

  rg3 = {
    name     = "lavjeetrg3"
    location = "southindia"
  }
}



stg_detials = {

  stg1 = {
    name                     = "lavjeetstorage1"
    resource_group_name      = "lavjeetrg1"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

  stg2 = {
    name                     = "lavjeetstorage2"
    resource_group_name      = "lavjeetrg2"
    location                 = "centralindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }

  stg3 = {
    name                     = "lavjeetstorage3"
    resource_group_name      = "lavjeetrg3"
    location                 = "southindia"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
