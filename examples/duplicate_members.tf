##################
# This ResourceTags example demonstrates an initiative containing duplicate member definitions
##################

### DEFINITIONS
module "inherit_resource_group_tags_modify" {
  source              = "..//modules/definition"
  policy_name         = "inherit_resource_group_tags_modify"
  display_name        = "Resources should inherit Resource Group Tags and Values with Modify Remediation"
  policy_category     = "Tags"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.org.id
}

module "require_resource_group_tags" {
  source              = "..//modules/definition"
  policy_name         = "require_resource_group_tags"
  display_name        = "ResourceGroups require specific tags to be present"
  policy_category     = "Tags"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.org.id
}

### INITIATIVE
module "resource_group_tags" {
  source                  = "..//modules/initiative"
  initiative_name         = "resource_group_tags"
  initiative_display_name = "[Tags]: Require & Inherit ResourceGroup Tags"
  initiative_description  = "Ensures ResourceGroup tags are inherited by its resources"
  initiative_category     = "Tags"
  management_group_id     = data.azurerm_management_group.team_a.id
  duplicate_members       = true  # this must be 'true' for the module to handle duplicate defs
  merge_parameters        = false # this must be 'false' for each occurance to have unique params and references

  # include the same policy as many time as needed
  # NOTE: be cautious when changing the position of members as these reflect the index numbers used in 'assignment_parameters' below
  member_definitions = [
    module.inherit_resource_group_tags_modify.definition,
    module.inherit_resource_group_tags_modify.definition,
    module.inherit_resource_group_tags_modify.definition,
    module.inherit_resource_group_tags_modify.definition,
    module.require_resource_group_tags.definition,
    module.require_resource_group_tags.definition,
    module.require_resource_group_tags.definition,
    module.require_resource_group_tags.definition,
  ]
}

### ASSIGNMENT
module "team_a_mg_resource_group_tags" {
  source              = "..//modules/set_assignment"
  initiative          = module.resource_group_tags.initiative
  assignment_scope    = data.azurerm_management_group.team_a.id
  assignment_location = "ukwest"

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment

  assignment_parameters = {
    tagName_0_InheritResourceGroupTagsModify = "DepartmentName"
    tagName_1_InheritResourceGroupTagsModify = "CostCode"
    tagName_2_InheritResourceGroupTagsModify = "ProductCode"
    tagName_3_InheritResourceGroupTagsModify = "Environment"
    tagName_4_RequireResourceGroupTags       = "DepartmentName"
    tagName_5_RequireResourceGroupTags       = "CostCode"
    tagName_6_RequireResourceGroupTags       = "ProductCode"
    tagName_7_RequireResourceGroupTags       = "Environment"
    effect_7_RequireResourceGroupTags        = "Disabled"
  }

  non_compliance_messages = module.resource_group_tags.non_compliance_messages
}
