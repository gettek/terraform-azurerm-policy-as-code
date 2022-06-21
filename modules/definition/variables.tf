variable management_group_id {
  type        = string
  description = "The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id."
  default     = null
}

variable policy_name {
  type        = string
  description = "Name to be used for this policy, when using the module library this should correspond to the correct category folder under /policies/policy_category/policy_name. Changing this forces a new resource to be created."
  default     = ""

  validation {
    condition     = length(var.policy_name) <= 64
    error_message = "Definition names have a maximum 64 character limit, ensure this matches the filename within the local policies library."
  }
}

variable display_name {
  type        = string
  description = "Display Name to be used for this policy"
  default     = ""

  validation {
    condition     = length(var.display_name) <= 128
    error_message = "Definition display names have a maximum 128 character limit."
  }
}

variable policy_description {
  type        = string
  description = "Policy definition description"
  default     = ""

  validation {
    condition     = length(var.policy_description) <= 512
    error_message = "Definition descriptions have a maximum 512 character limit."
  }
}

variable policy_mode {
  type        = string
  description = "The policy mode that allows you to specify which resource types will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data"
  default     = "All"
}

variable policy_category {
  type        = string
  description = "The category of the policy, when using the module library this should correspond to the correct category folder under /policies/var.policy_category"
  default     = null
}

variable policy_version {
  type        = string
  description = "The version for this policy, if different from the one stored in the definition metadata, defaults to 1.0.0"
  default     = null
}

variable policy_rule {
  type        = any
  description = "The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in /policies/var.policy_category/var.policy_name.json"
  default     = null
}

variable policy_parameters {
  type        = any
  description = "Parameters for the policy definition. This field is a JSON object that allows you to parameterise your policy definition. Omitting this assumes the parameters are located in /policies/var.policy_category/var.policy_name.json"
  default     = null
}

variable policy_metadata {
  type        = any
  description = "The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will fallback to meta in the definition or merge var.policy_category and var.policy_version"
  default     = null
}

variable file_path {
  type        = any
  description = "The filepath to the custom policy. Omitting this assumes the policy is located in the module library"
  default     = null
}

locals {
  # import the custom policy object from the library or specified file path
  policy_object = coalesce(
    try(jsondecode(file("${path.module}/../../policies/${title(var.policy_category)}/${var.policy_name}.json")), null),
    try(jsondecode(file(var.file_path)), null)
  )

  # fallbacks
  title = title(replace(local.policy_name, "/-|_|\\s/", " "))
  category = coalesce(var.policy_category, try((local.policy_object).properties.metadata.category, "General"))
  version = coalesce(var.policy_version, try((local.policy_object).properties.metadata.version, "1.0.0"))

  # use local library attributes if runtime inputs are omitted
  policy_name = coalesce(var.policy_name, try((local.policy_object).name, null))
  display_name = coalesce(var.display_name, try((local.policy_object).properties.displayName, local.title))
  description = coalesce(var.policy_description, try((local.policy_object).properties.description, local.title))
  policy_rule = coalesce(var.policy_rule, try((local.policy_object).properties.policyRule, null))
  parameters = coalesce(var.policy_parameters, try((local.policy_object).properties.parameters, null))
  metadata = coalesce(var.policy_metadata, try((local.policy_object).properties.metadata, merge({ category = local.category },{ version = local.version })))

  # manually generate the definition Id to prevent "Invalid for_each argument" on set_assignment plan/apply
  definition_id = var.management_group_id != null ? "${var.management_group_id}/providers/Microsoft.Authorization/policyDefinitions/${local.policy_name}" : azurerm_policy_definition.def.id
}
