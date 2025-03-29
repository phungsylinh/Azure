terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}
provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
    #subscription_id
  }
}
terraform {
    source = "git::https://github.com/phungsylinh/Azure.git//root?ref=main"
    extra_arguments "auto_tfvars_loader" {
        commands = get_terraform_commands_that_need_vars()
        optional_var_files = [
            "${get_repo_root()}/vnets.tfvars",
            "${get_repo_root()}/vms.tfvars"
        ]
    }
#before hook
}