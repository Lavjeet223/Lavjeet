# module "rgs" {
#   source = "./azurerm_resource_group"
# }

# module "stg" {
#   depends_on = [module.rgs]
#   source     = "./azurerm_storage_account"
# }

# module "vnet" {
#   depends_on = [module.rgs]
#   source     = "./azurerm_virtual_network"
# }

# module "subnet" {
#   depends_on = [module.vnet]
#   source     = "./azurerm_subnet"
# }

# module "public_ip" {
#   depends_on = [module.rgs]
#   source     = "./azurerm_public_ip"
# }

# module "nic" {
#   depends_on = [module.subnet]
#   source     = "./azurerm_network_interface_card"
#   subnetid   = data.azurerm_subnet.data_subnet.id
#   public_id  = data.azurerm_public_ip.data_public_ip.id
# }


# module "nsg" {
#   depends_on = [module.rgs]
#   source     = "./azurerm_network_security_group"
# }

# module "nsg_nic" {
#   source      = "./azurerm_network_interface_security_group_association"
#   nic_detials = data.azurerm_network_interface.data_nic.id
#   nsg_detials = data.azurerm_network_security_group.data-nsg.id
# }



# # module "key_vault" {
# #   depends_on = [module.rgs]
# #   source     = "./azurerm_key_vault"
# # }


# module "vm" {
#   depends_on = [module.nsg_nic]
#   source     = "./azurerm_virtual_machine"
#   nic_detials = data.azurerm_network_interface.data_nic.id
  
# }
