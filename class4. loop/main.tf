# resource "azurerm_resource_group" "rg_via_foreach_loop_block" {
#   for_each = var.foreach_loop_rg_details
#   name     = each.value
#   location = "centralindia"
# }


# ####rg with count loop
resource "azurerm_resource_group" "rg_via_count_loop_block" {
  count = 15    ## coun value must be 1 or greater. if you pass 0 mean it will not generate anything
  name     = "lavjeet${count.index+1}" # count index always start with 0 like here we asking for 5 then 0,1,2,3,4 
  location = "centralindia"
}


# # #### Rg with Advance count + list 

# # ### problem --> during removal of any rg from list then all count index will change whcih will impact all

# # resource "azurerm_resource_group" "rg_via__advacne_count_loop_block" {
# #   count = length(var.advance_count)
# #   name     = var.advance_count[count.index] # count index always start with 0 like here we asking for 5 then 0,1,2,3,4
# #   location = "centralindia"
# # }


