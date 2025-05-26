# module "rg" {
#   source = "../../module/azurerm_resource_group"
#   rg     = var.rg
# }


# module "stg" {
#   depends_on = [module.rg]
#   source     = "../../module/azurerm_storage_account"
#   rg         = var.rg
# }

# module "vnet" {
#   depends_on = [module.rg]
#   source     = "../../module/azurerm_virtual_network"
#   vnet       = var.vnet
# }

# module "subnet" {
#   depends_on = [module.vnet]
#   source     = "../../module/azurerm_subnet"
#   subnet     = var.subnet
# }
# module "bastion_subnet" {
#   depends_on = [module.subnet]
#   source     = "../../module/azurerm_bastion"
#   bastion    = var.bastion
# }

# module "vm" {
#   depends_on = [module.bastion_subnet]
#   source     = "../../module/azurerm_virtual_machine"
#   vms        = var.vms
# }

# # module "loadbalancer" {
# #   depends_on = [ module.vm ]
# #   source = "../../module/azure_loadbalancer"
# #   rg = var.rg
# #   vms = var.vms
# # }
