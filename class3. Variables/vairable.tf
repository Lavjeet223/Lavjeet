variable "rg_set_block_details" {
  type = set(string) #in Set values passed in [] and comma seprated and no duplicate value  & also mandatory to pass type = set( sting)
}


variable "rg_list_block_details" {
  type = list(string) #in Set values passed in [] and comma seprated and duplicate values are possible & also mandatory to pass type = toset( sting)
}

variable "rg_map_block_details" {
  type = map(any) #in Set values passed in {} and comma seprated and no duplicate values are possible & also mandatory to pass type = map( any) #in map we can pass anything. 
#in map value passed in key = value pair format
}

variable "rg_map_advance_block_details" {
  type = map(any) 
}


variable "stg_map_advance_block_detials" {
    type = map(any)
  
}