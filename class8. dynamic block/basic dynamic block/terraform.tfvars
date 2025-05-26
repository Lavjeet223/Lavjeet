vnet_details = {
  vnet1 = {
    name                = "Lavjeet-vnet1"
    resource_group_name = "Lavjeet"
    location            = "southindia"
    address_space       = ["10.120.0.0/16"]

  }


  vnet2 = {
    name                = "Lavjeet-vnet2"
    resource_group_name = "Lavjeet"
    location            = "southindia"
    address_space       = ["10.120.0.0/16"]




  }
}

subnet = {
  subnet1 = {
    name             = "frontend-subnet"
    address_prefixes = ["10.120.1.0/24"]
  }
  subnet2 = {
    name             = "backend-subnet"
    address_prefixes = ["10.120.2.0/24"]
  }
  subnet3 = {
    name             = "subnet3"
    address_prefixes = ["10.120.3.0/24"]
  }

}
