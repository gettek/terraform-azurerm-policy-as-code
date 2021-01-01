# Azure Policy Deployments

This examples folder demonstrates an effective deployment of Azure Policy Definitions and Assignments. The order of execution is generally from `definitions.tf` -> `initiatives.tf` -> `assignments_<scope>.tf`

### Resources

* azurerm_policy_definition.def
* azurerm_policy_set_definition.set
* azurerm_policy_set_definition.cis_benchmark
* azurerm_policy_assignment.def
* azurerm_policy_assignment.set
* azurerm_policy_remediation.rem
* random_uuid.org_mg_remediate_platform_diagnostics_initiative
* random_uuid.org_mg_add_replace_resource_group_tag_key_modify
* azurerm_role_definition.org_mg_remediate_platform_diagnostics_initiative
* azurerm_role_assignment.org_mg_add_replace_resource_group_tag_key_modify

