module "rgs" {
  source = "../../module/azurerm_resource_group"
  rg_map = var.rg_details
}

module "stg" {
  depends_on = [module.rgs]
  source     = "../../module/azurerm_storage_account"
  stg_map  = var.stg_detials
}
