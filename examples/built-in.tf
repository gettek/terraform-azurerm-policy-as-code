##################
# Built-In Initiative
##################
data "azurerm_policy_set_definition" "configure_az_monitor_linux_vm_initiative" {
  display_name = "Configure Linux machines to run Azure Monitor Agent and associate them to a Data Collection Rule"
}

##################
# Built-In Assignment
##################

module "org_mg_configure_az_monitor_linux_vm_initiative" {
  source           = "..//modules/set_assignment"
  initiative       = data.azurerm_policy_set_definition.configure_az_monitor_linux_vm_initiative
  assignment_scope = data.azurerm_management_group.org.id

  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]

  assignment_parameters = {
    listOfLinuxImageIdToInclude = []
    dcrResourceId               = "/Data/Collection/Rule/Resource/Id"
  }
}
