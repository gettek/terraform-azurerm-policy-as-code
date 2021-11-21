variable definition {
  type        = any
  description = "Policy Definition resource node"
}

variable assignment_scope {
  type        = string
  description = "The scope at which the policy will be assigned. Must be full resource IDs. Changing this forces a new resource to be created"
}

variable assignment_not_scopes {
  type        = list
  description = "A list of the Policy Assignment's excluded scopes. Must be full resource IDs"
  default     = []
}

variable assignment_display_name {
  type        = string
  description = "The policy assignment display name, if blank the definition display_name will be used. Changing this forces a new resource to be created"
  default     = ""
}

variable assignment_description {
  type        = string
  description = "A description to use for the Policy Assignment. Changing this forces a new resource to be created"
  default     = ""
}

variable assignment_effect {
  type        = string
  description = "The effect of the policy. Changing this forces a new resource to be created"
  default     = null
}

variable assignment_parameters {
  type        = any
  description = "The policy assignment parameters. Changing this forces a new resource to be created"
  default     = null
}

variable assignment_enforcement_mode {
  type        = bool
  description = "Control whether the assignment is enforced"
  default     = true
}

variable assignment_location {
  type        = string
  description = "The Azure location where this policy assignment should exist, required when an Identity is assigned. Defaults to UK South. Changing this forces a new resource to be created"
  default     = "uksouth"
}

variable resource_discovery_mode {
  type        = string
  description = "The way that resources to remediate are discovered. Possible values are ExistingNonCompliant, ReEvaluateCompliance. Defaults to ExistingNonCompliant."
  default     = "ExistingNonCompliant"
}

variable location_filters {
  type        = list
  description = "Optional list of the resource locations that will be remediated"
  default     = []
}

variable role_definition_ids {
  type        = list
  description = "List of Role definition ID's for the System Assigned Identity, defaults to roles included in the definition. Specify a blank array to skip creating role assignments. Changing this forces a new resource to be created"
  default     = []
}

variable role_assignment_scope {
  type        = string
  description = "The scope at which role definition(s) will be assigned, defaults to Policy Assignment Scope. Must be full resource IDs. Changing this forces a new resource to be created"
  default     = null
}

variable skip_remediation {
  type        = bool
  description = "Should the module skip creation of a remediation task for policies that DeployIfNotExists and Modify"
  default     = false
}

locals {
  # assignment_name will be trimmed if exceeds 24 characters
  assignment_name = lower(substr(var.definition.name, 0, 24))

  # evaluate policy assignment scope from resource identifier
  assignment_scope = try({
    mg = length(regexall("(\\/managementGroups\\/)", var.assignment_scope)) > 0 ? 1 : 0,
    sub = length(split("/", var.assignment_scope)) == 3 ? 1 : 0,
    rg = length(regexall("(\\/managementGroups\\/)", var.assignment_scope)) < 1 ? length(split("/", var.assignment_scope)) == 5 ? 1 : 0 : 0,
    resource = length(split("/", var.assignment_scope)) >= 6 ? 1 : 0,
  })

  # definition display_name will be used if omitted
  display_name = try(coalesce(var.assignment_display_name, var.definition.display_name), "")

  # definition discription will be used if omitted
  description = try(coalesce(var.assignment_description, var.definition.description), "")

  # convert assignment parameters to the required assignment structure
  parameter_values = var.assignment_parameters != null ? {
    for key, value in var.assignment_parameters :
    key => merge({ value = value })
  } : null

  # merge effect with parameter_values if specified, will use definition defaults if omitted
  parameters = var.assignment_effect != null ? jsonencode(merge(local.parameter_values, { effect = { value = var.assignment_effect } })) : jsonencode(local.parameter_values)

  # determine managed identity type from effect
  identity_type = var.assignment_effect != null ? contains(["DeployIfNotExists", "Modify"], var.assignment_effect) ? {type = "SystemAssigned"} : {} : {}

  # create a remediation task for policies with DeployIfNotExists and Modify effects only if var.skip_remediation != false
  create_remediation = var.skip_remediation == false ? var.assignment_effect != null ? contains(["DeployIfNotExists", "Modify"], var.assignment_effect) ? true : false : false : false

  # try to use policy definition roles if ommitted
  role_definition_ids = var.skip_remediation == false ? toset(try(coalescelist(var.role_definition_ids, try(jsondecode(var.definition.policy_rule).then.details.roleDefinitionIds, [])), [])) : []
  
  # policy assignment scope will be used if omitted
  role_assignment_scope = try(coalesce(var.role_assignment_scope, var.assignment_scope), "")

  # evaluate assignment outputs
  assignment_id = try(
    azurerm_management_group_policy_assignment.def[0].id,
    azurerm_subscription_policy_assignment.def[0].id,
    azurerm_resource_group_policy_assignment.def[0].id,
    azurerm_resource_policy_assignment.def[0].id,
    "")
  principal_id = try(
    azurerm_management_group_policy_assignment.def[0].identity[0].principal_id,
    azurerm_subscription_policy_assignment.def[0].identity[0].principal_id,
    azurerm_resource_group_policy_assignment.def[0].identity[0].principal_id,
    azurerm_resource_policy_assignment.def[0].identity[0].principal_id,
    "")
}
