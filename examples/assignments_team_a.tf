##################
# General
##################
module "team_a_mg_deny_resources_types" {
  source            = "..//modules/def_assignment"
  definition        = module.deny_resources_types.definition
  assignment_scope  = data.azurerm_management_group.team_a.id
  assignment_effect = "Audit"

  assignment_parameters = {
    listOfResourceTypesNotAllowed = [
      "Microsoft.Storage/operations",
      "Microsoft.Storage/storageAccounts",
      "Microsoft.Storage/storageAccounts/blobServices",
      "Microsoft.Storage/storageAccounts/blobServices/containers",
      "Microsoft.Storage/storageAccounts/listAccountSas",
      "Microsoft.Storage/storageAccounts/listServiceSas",
      "Microsoft.Storage/usages",
    ]
  }
}

##################
# Network
##################
module "team_a_mg_deny_nic_public_ip" {
  source            = "..//modules/def_assignment"
  definition        = module.deny_nic_public_ip.definition
  assignment_scope  = data.azurerm_management_group.team_a.id
  assignment_effect = "Deny"
}

##################
# Tags
##################

module "team_a_mg_inherit_resource_group_tags_modify" {
  source            = "..//modules/def_assignment"
  definition        = module.inherit_resource_group_tags_modify.definition
  assignment_scope  = data.azurerm_management_group.team_a.id
  assignment_effect = "Modify"
  skip_remediation  = var.skip_remediation

  assignment_parameters = {
    tagName = "environment"
  }
}
