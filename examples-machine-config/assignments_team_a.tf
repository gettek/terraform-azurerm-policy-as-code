##################
# Guest Configuration
##################

# Assign Prerequisits Initiative
module "team_a_mg_guest_config_prereqs_initiative" {
  source                  = "..//modules/set_assignment"
  initiative              = data.azurerm_policy_set_definition.deploy_guest_config_prereqs_initiative
  assignment_scope        = data.azurerm_management_group.team_a.id
  skip_remediation        = var.skip_remediation
  skip_role_assignment    = var.skip_role_assignment
  resource_discovery_mode = local.resource_discovery_mode

  # built-ins that deploy/modify require role_definition_ids be present
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id
  ]
}

# Assign Custom Machine Configs Initiative
module "team_a_mg_vm_custom_machine_configs" {
  source                  = "..//modules/set_assignment"
  initiative              = module.custom_guest_configs_initiative.initiative
  assignment_scope        = data.azurerm_management_group.team_a.id
  skip_remediation        = var.skip_remediation
  skip_role_assignment    = var.skip_role_assignment
  resource_discovery_mode = local.resource_discovery_mode

  assignment_parameters = {
    IncludeArcMachines = "false"
  }
}
