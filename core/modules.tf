# module "vnets" {
#     #source = "../vnets"
#     source = "./vnets"
#     depends_on = [module.resource_groups]
# }
module "vms" {
    source = "./vms"
    vms=var.vms
    #depends_on = [module.resource_groups]
}
