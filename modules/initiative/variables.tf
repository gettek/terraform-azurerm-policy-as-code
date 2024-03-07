variable "management_group_id" {
  type        = string
  description = "The management group scope at which the initiative will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id."
  default     = null
}

variable "initiative_name" {
  type        = string
  description = "Policy initiative name. Changing this forces a new resource to be created"

  validation {
    condition     = length(var.initiative_name) <= 64
    error_message = "Initiative names have a maximum 64 character limit."
  }
}

variable "initiative_display_name" {
  type        = string
  description = "Policy initiative display name"

  validation {
    condition     = length(var.initiative_display_name) <= 128
    error_message = "Initiative display names have a maximum 128 character limit."
  }
}

variable "initiative_description" {
  type        = string
  description = "Policy initiative description"
  default     = ""

  validation {
    condition     = length(var.initiative_description) <= 512
    error_message = "Initiative descriptions have a maximum 512 character limit."
  }
}

variable "initiative_category" {
  type        = string
  description = "The category of the initiative"
  default     = "General"
}

variable "initiative_version" {
  type        = string
  description = "The version for this initiative, defaults to 1.0.0"
  default     = "1.0.0"
}

variable "member_definitions" {
  type        = any
  description = "Policy Definition resource nodes that will be members of this initiative"
}

variable "initiative_metadata" {
  type        = any
  description = "The metadata for the policy initiative. This is a JSON object representing additional metadata that should be stored with the policy initiative. Omitting this will default to merge var.initiative_category and var.initiative_version"
  default     = null
}

variable "merge_effects" {
  type        = bool
  description = "Should the module merge all member definition effects? Defaults to true"
  default     = true
}

variable "merge_parameters" {
  type        = bool
  description = "Should the module merge all member definition parameters? Defaults to true"
  default     = true
}

variable "duplicate_members" {
  type        = bool
  description = "Does the Initiative contain duplicate member definitions? Defaults to false"
  default     = false
}

locals {
  # colate all definition properties into a single reusable object:
  # - definition references take their policy name transformed to upper camel case
  # - index numbers (idx) will be prefixed to references when using duplicate member definitions
  member_properties = {
    for idx, d in var.member_definitions :
    var.duplicate_members == false ? d.name : "${idx}_${d.name}" => {
      id                     = d.id
      mode                   = try(d.mode, "")
      reference              = var.duplicate_members == false ? replace(title(replace(d.name, "/-|_|\\s/", " ")), "/\\s/", "") : "${idx}_${replace(title(replace(d.name, "/-|_|\\s/", " ")), "/\\s/", "")}"
      parameters             = try(jsondecode(d.parameters), {})
      category               = try(jsondecode(d.metadata).category, "")
      version                = try(jsondecode(d.metadata).version, "1.*.*")
      non_compliance_message = try(jsondecode(d.metadata).non_compliance_message, d.description, d.display_name, "Flagged by Policy: ${d.name}")
      role_definition_ids    = try(jsondecode(d.policy_rule).then.details.roleDefinitionIds, [])
    }
  }

  # combine all discovered definition parameters using interpolation
  parameters = merge(values({
    for definition, properties in local.member_properties :
    definition => {
      for parameter_name, parameter_value in properties.parameters :
      # if do not merge parameters (or only effects) then suffix parameters with definition references
      var.merge_parameters == false || parameter_name == "effect" && var.merge_effects == false ?
      "${parameter_name}_${properties.reference}" :

      parameter_name => {
        for k, v in parameter_value :
        k => (
          # if do not merge parameters (or only effects) then suffix displayNames with definition references
          k == "metadata" && var.merge_parameters == false || var.merge_effects == false && try(v.displayName, "") == "Effect" ?
          merge(v, { displayName = "${v.displayName} For Policy: ${properties.reference}" }) :
          v
        )
      }
    }
  })...)

  # generate replacement trigger by hashing parameters, included as an output to prevent regen at assignment
  replace_trigger = md5(jsonencode(local.parameters))

  # combine all role definition IDs present in the policyRule
  all_role_definition_ids = try(distinct([for v in flatten(values({
    for k, v in local.member_properties :
    k => v.role_definition_ids
  })) : lower(v)]), [])

  metadata = coalesce(null, var.initiative_metadata, merge({ category = var.initiative_category }, { version = var.initiative_version }))

  # build non-compliance messages from metadata, or default to description/display_name if not present
  non_compliance_messages = merge(
    { null = "Flagged by Initiative: ${var.initiative_name}" }, # default non-compliance message
    { for k, v in local.member_properties :
      v.reference => v.non_compliance_message
      if contains(["All", "Indexed"], v.mode) && var.duplicate_members == false # messages fail on other modes
    }
  )

  # manually generate the initiative Id to prevent "Invalid for_each argument" on potential consumer modules
  initiative_id = var.management_group_id != null ? "${var.management_group_id}/providers/Microsoft.Authorization/policySetDefinitions/${var.initiative_name}" : azurerm_policy_set_definition.set.id
}
