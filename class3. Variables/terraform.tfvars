rg_set_block_details = [
  "setrg1",
  "setrg2",
  "setrg3", "setrg4", "setrg5"
]


rg_list_block_details = [
  "listrg1",
  "listrg2",
  "listrg3", "listrg3", "listrg3"
]



rg_map_block_details = {
  rg1 = {
    name     = "maprg1"
    location = "westus"
  }
  rg2 = {
    name     = "maprg2"
    location = "centralindia"
  }
  rg3 = {
    name     = "maprg3"
    location = "southindia"
  }

}



rg_map_advance_block_details = {

  advancerg1 = "westus"
  advancerg2 = "southindia"
  advancerg3 = "westindia"

}




stg_map_advance_block_detials = {
  lavmapadvancestg1key = {
    name                     = "lavmapadvancestg1"
    resource_group_name      = "advancerg1"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  lavmapadvancestg2key = {
    name                     = "lavmapadvancestg2"
    resource_group_name      = "advancerg2"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
  lavmapadvancestg3key = {
    name                     = "lavmapadvancestg3"
    resource_group_name      = "advancerg3"
    location                 = "westus"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}
