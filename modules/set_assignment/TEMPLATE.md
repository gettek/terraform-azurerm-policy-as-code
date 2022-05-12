# POLICY INITIATIVE ASSIGNMENT MODULE

Assignments can be scoped from overarching management groups right down to individual resources

> 💡 To automate Role Assignment and Remediation you must explicitly parse a list of required `role_definition_ids` to this module as seen below. You may choose to assign roles at a different scope to that of the policy assignment (default) using `role_assignment_scope`.

## Examples

### Custom Policy Initiative Assignment with Not-Scope
```hcl
module org_mg_configure_asc_initiative {
  source               = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative           = module.configure_asc_initiative.initiative
  assignment_scope     = data.azurerm_management_group.org.id
  assignment_effect    = "DeployIfNotExists"
  skip_remediation     = false
  skip_role_assignment = false
  role_definition_ids  = module.configure_asc_initiative.role_definition_ids

  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }

  assignment_not_scopes = [
    data.azurerm_management_group.team_a.id
  ]

  non_compliance_message = "Example non-compliance message will be used as opposed to default policy error"
}
```

### Built-In Policy Initiative Assignment
```hcl
data "azurerm_policy_set_definition" "cis_1_3_0" {
  display_name = "CIS Microsoft Azure Foundations Benchmark v1.3.0"
}

module org_mg_cis_1_3_0_benchmark {
  source           = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative       = data.azurerm_policy_set_definition.cis_1_3_0
  assignment_scope = data.azurerm_management_group.org.id

  assignment_parameters = {
    "effect-b954148f-4c11-4c38-8221-be76711e194a-MicrosoftSql-servers-firewallRules-delete" = "Disabled"
  }
}
```

### Built-In Policy Initiative Containing DINE/Modify Assignment

```hcl
data "azurerm_policy_set_definition" "configure_az_monitor_linux_vm_initiative" {
  display_name = "Configure Linux machines to run Azure Monitor Agent and associate them to a Data Collection Rule"
}

data "azurerm_role_definition" "vm_contributor" {
  name = "Virtual Machine Contributor"
}

module org_mg_configure_az_monitor_linux_vm_initiative {
  source           = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative       = data.azurerm_policy_set_definition.configure_az_monitor_linux_vm_initiative
  assignment_scope = data.azurerm_management_group.org.id
  skip_remediation = false

  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]

  assignment_parameters = {
    listOfLinuxImageIdToInclude = []
    dcrResourceId               = "/Data/Collection/Rule/Resource/Id"
  }
}
```
