variable management_group_id {
  type        = string
  description = "The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created. Note: if you are using azurerm_management_group to assign a value to management_group_id, be sure to use name or group_id attribute, but not id."
  default     = null
}

variable policy_name {
  type        = string
  description = "Name to be used for this policy, this should correspond to the correct category folder under /policies/policy_category/policy_name. Changing this forces a new resource to be created."

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
  description = "The category of the policy, should correspond to the correct category folder under /policies/var.policy_category"
  default     = ""

  validation {
    condition     = var.policy_category != ""
    error_message = "The policy category is required and should match the folder name of the custom policy definition under /policies/policy_category."
  }
}

variable policy_version {
  type        = string
  description = "The version for this policy, defaults to 1.0.0"
  default     = "1.0.0"
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

locals {
  # import the custom policy object from the library
  policy_object = jsondecode(file("${path.module}/../../policies/${title(var.policy_category)}/${var.policy_name}.json"))

  # title case the policy name as a fallback for when display names and descriptions do not exist
  policy_name = title(replace(var.policy_name, "/-|_|\\s/", " "))

  # use local library attributes if runtime vars omitted
  display_name = coalesce(var.display_name, try((local.policy_object).properties.displayName, local.policy_name))
  description = coalesce(var.policy_description, try((local.policy_object).properties.description, local.policy_name))
  policy_rule = coalesce(var.policy_rule, try((local.policy_object).properties.policyRule, {}))
  parameters = coalesce(var.policy_parameters, try((local.policy_object).properties.parameters, {}))
  metadata = coalesce(var.policy_metadata, try((local.policy_object).properties.metadata, merge({ category = var.policy_category },{ version = var.policy_version })))

  # manually generate the definition Id to prevent "Invalid for_each argument" on set_assignment plan/apply
  definition_id = var.management_group_id != null ? "${var.management_group_id}/providers/Microsoft.Authorization/policyDefinitions/${var.policy_name}" : azurerm_policy_definition.def.id
}
