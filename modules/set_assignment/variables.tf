variable initiative {
  type        = any
  description = "Policy Initiative resource node"
}

variable assignment_scope {
  type        = string
  description = "The scope at which the policy initiative will be assigned. Must be full resource IDs. Changing this forces a new resource to be created"
}

variable assignment_not_scopes {
  type        = list(any)
  description = "A list of the Policy Assignment's excluded scopes. Must be full resource IDs"
  default     = []
}

variable assignment_name {
  type        = string
  description = "The name which should be used for this Policy Assignment, defaults to initiative name. Changing this forces a new Policy Assignment to be created"
  default     = ""
}

variable assignment_display_name {
  type        = string
  description = "The policy assignment display name, defaults to initiative display_name. Changing this forces a new resource to be created"
  default     = ""
}

variable assignment_description {
  type        = string
  description = "A description to use for the Policy Assignment, defaults to initiative description. Changing this forces a new resource to be created"
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

variable non_compliance_message {
  type        = string
  description = "The optional non-compliance message text. This message will be the default for all member definitions in the set."
  default     = ""
}

variable resource_discovery_mode {
  type        = string
  description = "The way that resources to remediate are discovered. Possible values are ExistingNonCompliant or ReEvaluateCompliance. Defaults to ExistingNonCompliant"
  default     = "ExistingNonCompliant"

  validation {
    condition     = var.resource_discovery_mode == "ExistingNonCompliant" || var.resource_discovery_mode == "ReEvaluateCompliance"
    error_message = "Resource Discovery Mode possible values are: ExistingNonCompliant or ReEvaluateCompliance."
  }
}

variable location_filters {
  type        = list(any)
  description = "Optional list of the resource locations that will be remediated"
  default     = []
}

variable role_definition_ids {
  type        = list(string)
  description = "List of Role definition ID's for the System Assigned Identity. Omit this to use those located in policy definitions. Changing this forces a new resource to be created"
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

variable skip_role_assignment {
  type        = bool
  description = "Should the module skip creation of role assignment for policies that DeployIfNotExists and Modify"
  default     = false
}

locals {
  # evaluate policy assignment scope from resource identifier
  assignment_scope = try({
    mg       = length(regexall("(\\/managementGroups\\/)", var.assignment_scope)) > 0 ? 1 : 0,
    sub      = length(split("/", var.assignment_scope)) == 3 ? 1 : 0,
    rg       = length(regexall("(\\/managementGroups\\/)", var.assignment_scope)) < 1 ? length(split("/", var.assignment_scope)) == 5 ? 1 : 0 : 0,
    resource = length(split("/", var.assignment_scope)) >= 6 ? 1 : 0,
  })

  # assignment_name will be trimmed if exceeds 24 characters
  assignment_name = try(lower(substr(coalesce(var.assignment_name, var.initiative.name), 0, 24)), "")

  # initiative display_name will be used if omitted
  display_name = try(coalesce(var.assignment_display_name, var.initiative.display_name), "")

  # initiative discription will be used if omitted
  description = try(coalesce(var.assignment_description, var.initiative.description), "")

  # convert assignment parameters to the required assignment structure
  parameter_values = var.assignment_parameters != null ? {
    for key, value in var.assignment_parameters :
    key => merge({ value = value })
  } : null

  # merge effect and parameter_values if specified, will use definition default effects if omitted
  parameters = var.assignment_effect != null ? jsonencode(merge(local.parameter_values, { effect = { value = var.assignment_effect } })) : jsonencode(local.parameter_values)

  # create the optional non-compliance message contents block if present
  non_compliance_message = var.non_compliance_message != "" ? { content = var.non_compliance_message } : {}

  # try to use policy definition roles if input is ommitted
  role_definition_ids = var.skip_role_assignment == false ? toset(try(var.role_definition_ids, [])) : []

  # policy assignment scope will be used if input is omitted
  role_assignment_scope = coalesce(var.role_assignment_scope, var.assignment_scope)

  # determine managed identity type
  identity_type = length(try(var.role_definition_ids, [])) > 0 ? { type = "SystemAssigned" } : {}

  # if creating role assignments, retrieve definition references & create a remediation task for policies with DeployIfNotExists and Modify effects
  definitions = length(local.role_definition_ids) > 0 ? try(var.initiative.policy_definition_reference, []) : []
  definition_reference = try({
    mg       = local.assignment_scope.mg > 0 ? local.definitions : []
    sub      = local.assignment_scope.sub > 0 ? local.definitions : []
    rg       = local.assignment_scope.rg > 0 ? local.definitions : []
    resource = local.assignment_scope.resource > 0 ? local.definitions : []
  })

  # evaluate assignment outputs
  assignment = try(
    azurerm_management_group_policy_assignment.set[0],
    azurerm_subscription_policy_assignment.set[0],
    azurerm_resource_group_policy_assignment.set[0],
    azurerm_resource_policy_assignment.set[0],
  "")
  remediation_tasks = try(
    azurerm_management_group_policy_remediation.rem,
    azurerm_subscription_policy_remediation.rem,
    azurerm_resource_group_policy_remediation.rem,
    azurerm_resource_policy_remediation.rem,
  {})
}
