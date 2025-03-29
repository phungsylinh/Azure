# terraform {
#   required_providers {
#     azurerm = {
#       source  = "hashicorp/azurerm"
#       version = "~> 3.0.2"
#     }
#   }

#   required_version = ">= 1.1.0"
# }
# provider "azurerm" {
#   features {
#     resource_group {
#       prevent_deletion_if_contains_resources = false
#     }
#     #subscription_id
#     #skip_provider_registration
#   }
# }

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
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
  }
}
EOF
}

terraform {
    source = "git::https://github.com/phungsylinh/Azure.git//root?ref=main"
    extra_arguments "auto_tfvars_loader" {
        commands = get_terraform_commands_that_need_vars()
        optional_var_files = [
            "${get_repo_root()}/vms/default.tfvars"
            #"${get_repo_root()}/vnets/default.tfvars"
        ]
    }
        before_hook "merge_variables" {
        commands = ["init", "plan", "apply", "destory"]
        execute  = ["bash", "merge.sh"]
    }
#before hook
}
