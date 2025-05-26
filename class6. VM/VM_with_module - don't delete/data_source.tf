# # data "azurerm_resource_group" "data_rg" {
# #   name = "Ram-rg"
# # }

# data "azurerm_subnet" "data_subnet" {
#   depends_on           = [module.subnet]
#   name                 = "ram-subnet"
#   virtual_network_name = "ram-vnet"
#   resource_group_name  = "Ram-rg"
# }



# data "azurerm_public_ip" "data_public_ip" {
#   depends_on          = [module.public_ip]
#   name                = "ram-pip"
#   resource_group_name = "Ram-rg"
# }

# data "azurerm_network_interface" "data_nic" {
#   depends_on          = [module.nic]
#   name                = "ram-nic"
#   resource_group_name = "Ram-rg"
# }


# data "azurerm_network_security_group" "data-nsg" {
#   depends_on          = [module.nsg]
#   name                = "ram-nsg"
#   resource_group_name = "Ram-rg"
# }
