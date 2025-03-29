prefix = "tfvmex"

vms = {
  vm01 = {
    size = "Standard_DS2_v2"
    zone = ["1"]
    nic = {
      name = "vm01-nic"
    }
    tags = {
      environment = "dev"
      owner       = "team-a"
    }
  }

  vm02 = {
    nic = {
      name = "vm02-nic"
    }
    tags = {
      environment = "prod"
      critical    = "true"
    }
  }
}
