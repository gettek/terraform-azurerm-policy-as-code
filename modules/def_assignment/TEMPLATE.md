# POLICY DEFINITION ASSIGNMENT MODULE

Assignments can be scoped from overarching management groups right down to individual resources

## Examples


### Assign a definition with Modify effect to automatically create a role assignment and remediation task

```hcl
module customer_mg_inherit_resource_group_tags_modify {
  source            = "gettek/policy-as-code/azurerm//modules/def_assignment"
  definition        = module.inherit_resource_group_tags_modify.definition
  assignment_scope  = data.azurerm_management_group.team_a.id
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

module customer_mg_inherit_resource_group_tags_modify {
  source            = "gettek/policy-as-code/azurerm//modules/def_assignment"
  definition        = module.inherit_resource_group_tags_modify.definition
  assignment_scope  = data.azurerm_management_group.team_a.id
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
