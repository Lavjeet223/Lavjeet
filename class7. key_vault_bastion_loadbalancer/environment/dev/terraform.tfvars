# rg = {
#   rg1 = {
#     resource_group_name = "radhakrishan"
#     location            = "southindia"
#   }
# }



# vnet = {
#   vnet1 = {
#     vnet_name           = "Radhakrishan-vnet"
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     address_space       = ["10.120.0.0/16"]
#   }
# }


# subnet = {
#   subnet1 = {
#     subnet_name         = "Radhakrishan-subnet1"
#     vnet_name           = "Radhakrishan-vnet"
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     address_prefixes    = ["10.120.10.0/24"]

#   }

#   subnet2 = {
#     subnet_name         = "Radhakrishan-subnet2"
#     vnet_name           = "Radhakrishan-vnet"
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     address_prefixes    = ["10.120.20.0/24"]

#   }

#   subnet3 = {
#     subnet_name         = "AzureBastionSubnet"
#     vnet_name           = "Radhakrishan-vnet"
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     address_prefixes    = ["10.120.0.0/26"]

#   }
# }

# bastion = {
#   bastion1 = {
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     vnet_name           = "Radhakrishan-vnet"
#   }
# }

# vms = {
#   vm1 = {
#     vm_name             = "Radha"
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     vnet_name           = "Radhakrishan-vnet"
#     subnet_name         = "Radhakrishan-subnet1"

#     size = "Standard_F2"
#   }

#   vm2 = {
#     vm_name             = "Krishan"
#     resource_group_name = "Radhakrishan"
#     location            = "southindia"
#     vnet_name           = "Radhakrishan-vnet"
#     subnet_name         = "Radhakrishan-subnet2"
#     size                = "Standard_F2"
#   }
# }
