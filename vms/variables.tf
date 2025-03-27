variable "prefix" {
  default = "tfvmex"
}
variable vms {
    type = map(object({              
        size = optional(string,"Standard_DS1_v2")
        zone = optional(list(string),["1"])                 
        nic = object({
            name = string          
        })                
        # storage_os_disk = object({
        # })         
        # os_profile = optional(object({
        # }))  
        # os_profile_linux_config = optional(object({
        # }))
        # os_profile_windows_config = optional(object({
        # }))               
        # boot_diagnostics = object({
        # })        
        # ultra_ssd_enabled = optional(bool)
        # delete_data_disks_on_termination = optional(bool) 
        # delete_os_disk_on_termination = optional(bool)         
        # vm_image_id = optional(string)  
        # vm_image_reference = optional(object({
        # }))      
        # storage_data_disks = optional(map(object({
        # })), {})
        tags = optional(map(string))
    }))
    default = {}
}