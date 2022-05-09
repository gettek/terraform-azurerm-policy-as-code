# POLICY DEFINITION ASSIGNMENT MODULE

Assignments can be scoped from overarching management groups right down to individual resources.

> 💡 A role assignment and remediation task will be automatically created if the Policy Definition contains a list of `roleDefinitionIds`. This can be omitted with `skip_role_assignment = true`, the scope can also be changed by setting `role_assignment_scope`.

## Examples


### Assign a definition with Modify effect to automatically create a role assignment and remediation task

```hcl
module team_a_mg_inherit_resource_group_tags_modify {
  source            = "gettek/policy-as-code/azurerm//modules/def_assignment"
  definition        = module.inherit_resource_group_tags_modify.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "Modify"
  skip_remediation  = var.skip_remediation

  assignment_parameters = {
    tagName = "environment"
  }
}
```

### Assign a definition with Modify effect to automatically create a role assignment and remediation task with an explicit role

```hcl
data azurerm_role_definition contributor {
  name = "Contributor"
}

module team_a_mg_inherit_resource_group_tags_modify {
  source            = "gettek/policy-as-code/azurerm//modules/def_assignment"
  definition        = module.inherit_resource_group_tags_modify.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "Modify"
  skip_remediation  = var.skip_remediation

  role_definition_ids = [
      data.azurerm_role_definition.contributor
  ]
  role_assignment_scope = "omit this to assign at same scope as policy assignment"

  assignment_parameters = {
    tagName = "environment"
  }
}
```

### Create a Built-In Policy Definition Assignment with Custom Non-Compliance Message

```hcl
data azurerm_policy_definition deploy_law_on_linux_vms {
  display_name = "Deploy Log Analytics extension for Linux VMs"
}

module team_a_mg_inherit_resource_group_tags_modify {
  source            = "gettek/policy-as-code/azurerm//modules/def_assignment"
  definition        = data.azurerm_policy_definition.deploy_law_on_linux_vms
  assignment_scope  = data.azurerm_management_group.org.id
  skip_remediation  = var.skip_remediation

  assignment_parameters = {
    logAnalytics           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    listOfImageIdToInclude = [
      local.dummy_resource_ids.custom_linux_image_id
    ]
  }

  non_compliance_message = "Example non-compliance message will be used as opposed to default policy error"
}
```
