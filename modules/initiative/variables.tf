variable management_group_name {
  type        = string
  description = "The scope at which the initiative will be defined. Currently this must be the group_id of a management group. Changing this forces a new resource to be created"
  default     = null
}

variable initiative_name {
  type        = string
  description = "Policy initiative name. Changing this forces a new resource to be created"
}

variable initiative_display_name {
  type        = string
  description = "Policy initiative display name"
}

variable initiative_description {
  type        = string
  description = "Policy initiative description"
  default     = ""
}

variable initiative_category {
  type        = string
  description = "The category of the initiative"
  default     = "General"
}

variable initiative_version {
  type        = string
  description = "The version for this initiative, defaults to 1.0.0"
  default     = "1.0.0"
}

variable member_definitions {
  type        = any
  description = "Policy Defenition resource nodes that will be members of this initiative"
}

locals {
  parameters = {
    for d in var.member_definitions :
    d.name => try(jsondecode(d.parameters), null)
  }

  # combine all discovered definition parameters using interpolation
  all_parameters = jsonencode(merge(values(local.parameters)...))

  # get role definition IDs
  role_definition_ids = {
    for d in var.member_definitions :
    d.id => try(jsondecode(d.policy_rule).then.details.roleDefinitionIds, [])
  }

  # combine all discovered role definition IDs
  all_role_definition_ids = distinct([for v in flatten(values(local.role_definition_ids)) : lower(v)])
  
  metadata = jsonencode(merge(
    { category = var.initiative_category },
    { version = var.initiative_version },
  ))
}
