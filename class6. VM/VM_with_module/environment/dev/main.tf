module "rg" {
  source = "../../module/azurerm_resource_group"
  vms    = var.vms
}


module "stg" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_storage_account"
  vms        = var.vms
}

module "vnet" {
  depends_on = [module.rg]
  source     = "../../module/azurerm_virtual_network"
  vms        = var.vms
}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../module/azurerm_subnet"
  vms        = var.vms
}

module "vm" {
  depends_on = [module.subnet]
  source     = "../../module/azurerm_virtual_machine"
  vms        = var.vms
}