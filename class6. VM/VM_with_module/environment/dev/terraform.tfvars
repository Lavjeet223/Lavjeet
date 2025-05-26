vms = {
  vm1 = {
    resource_group_name = "bholenath"
    location            = "southindia"
    address_space       = ["10.120.0.0/16"]
    address_prefixes    = ["10.120.1.0/24"]
    size                = "Standard_F2"
  }

  vm2 = {
    resource_group_name = "sitaram"
    location            = "southindia"
    address_space       = ["10.130.0.0/16"]
    address_prefixes    = ["10.130.1.0/24"]
    size                = "Standard_F2"
  }
}