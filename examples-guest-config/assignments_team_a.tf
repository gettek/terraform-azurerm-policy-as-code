##################
# Guest Configuration
##################

# Onboarding Prerequisites
module "team_a_mg_guest_config_prereqs_initiative" {
  source              = "..//modules/set_assignment"
  initiative          = module.guest_config_prereqs_initiative.initiative
  assignment_scope    = data.azurerm_management_group.team_a.id
  skip_remediation    = var.skip_remediation
  role_definition_ids = module.guest_config_prereqs_initiative.role_definition_ids
  assignment_parameters = {
    listOfImageIdToInclude_windows = []
    listOfImageIdToInclude_linux   = []
  }
}

# Custom Config Packages
module "team_a_mg_vm_custom_guest_configs" {
  source           = "..//modules/def_assignment"
  for_each         = data.azurerm_policy_definition.custom_guest_config_definitions
  definition       = each.value
  assignment_scope = data.azurerm_management_group.team_a.id
  skip_remediation = var.skip_remediation
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]
  assignment_parameters = {
    IncludeArcMachines = "False"
  }

  depends_on = [
    null_resource.guest_config_packages_script
  ]
}
