# POLICY INITIATIVE ASSIGNMENT MODULE

Assignments can be scoped from overarching management groups right down to individual resources

> 💡 To automate Role Assignment and Remediation you must explicitly parse a list of required `role_definition_ids` to this module. Specify a `role_assignment_scope` to change role assignments to a lower scope beneath the Policy assignment.

> ⚠️ **Warning:** You may experience plan/apply issues when running an initial deployment of a `set_assignment`. This is because `azurerm_role_assignment.rem_role` and `azurerm_policy_remediation.rem` depend on resources to exist before producing a successful deployment. To overcome this, set the flag `-var "skip_remediation=true"` and omit for consecutive builds. This may also be required for destroy tasks.

## Examples

### Custom Policy Initiative Assignment
```hcl
module org_mg_configure_asc_initiative {
  source               = "gettek/policy-as-code/azurerm//modules/set_assignment"
  initiative           = module.configure_asc_initiative.initiative
  assignment_scope     = data.azurerm_management_group.org.id
  assignment_effect    = "DeployIfNotExists"
  skip_remediation     = var.skip_remediation
  skip_role_assignment = false
  role_definition_ids  = module.configure_asc_initiative.role_definition_ids
  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }
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
  skip_remediation = var.skip_remediation
  role_definition_ids = [
    data.azurerm_role_definition.vm_contributor.id
  ]
  assignment_parameters = {
    listOfLinuxImageIdToInclude = []
    dcrResourceId                 = "/Data/Collection/Rule/Resource/Id"
  }
}
```
