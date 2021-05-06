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
    jsondecode(d.parameters) == null ? null :
    d.name => jsondecode(d.parameters)
  }

  all_parameters = jsonencode(merge(values(local.parameters)...))
  
  metadata = jsonencode(merge(
    { createdBy = data.azurerm_client_config.current.client_id },
    { category = var.initiative_category },
    { createdOn = timestamp() },
    { updatedBy = "" },
    { updatedOn = "" },
    { version = var.initiative_version },
  ))
}
