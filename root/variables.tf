module "vnets" {
    source = "../vnets"
    depends_on = [module.resource_groups]
}
module "vms" {
    source = "../vms"
    depends_on = [module.resource_groups]
}