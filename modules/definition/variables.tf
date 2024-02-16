variable "management_group_id" {
  type        = string
  description = "The management group scope at which the policy will be defined. Defaults to current Subscription if omitted. Changing this forces a new resource to be created."
  default     = null
}

variable "policy_name" {
  type        = string
  description = "Name to be used for this policy, when using the module library this should correspond to the correct category folder under /policies/policy_category/policy_name. Changing this forces a new resource to be created."
  default     = ""

  validation {
    condition     = length(var.policy_name) <= 64
    error_message = "Definition names have a maximum 64 character limit, ensure this matches the filename within the local policies library."
  }
}

variable "display_name" {
  type        = string
  description = "Display Name to be used for this policy"
  default     = ""

  validation {
    condition     = length(var.display_name) <= 128
    error_message = "Definition display names have a maximum 128 character limit."
  }
}

variable "policy_description" {
  type        = string
  description = "Policy definition description"
  default     = ""

  validation {
    condition     = length(var.policy_description) <= 512
    error_message = "Definition descriptions have a maximum 512 character limit."
  }
}

variable "policy_mode" {
  type        = string
  description = "Specify which Resource Provider modes will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.Kubernetes.Data, Microsoft.KeyVault.Data or Microsoft.Network.Data"
  default     = null

  validation {
    condition     = var.policy_mode == null || var.policy_mode == "All" || var.policy_mode == "Indexed" || var.policy_mode == "Microsoft.Kubernetes.Data" || var.policy_mode == "Microsoft.KeyVault.Data" || var.policy_mode == "Microsoft.Network.Data"
    error_message = "Policy mode possible values are: All, Indexed, Microsoft.Kubernetes.Data, Microsoft.KeyVault.Data or Microsoft.Network.Data. Unless explicitly stated, Resource Provider modes only support built-in policy definitions, and exemptions are not supported at the component-level."
  }
}

variable "policy_category" {
  type        = string
  description = "The category of the policy, when using the module library this should correspond to the correct category folder under /policies/<policy_category>"
  default     = null
}

variable "policy_version" {
  type        = string
  description = "The version for this policy, if different from the one stored in the definition metadata, defaults to 1.0.0"
  default     = null
}

variable "policy_rule" {
  type        = any
  description = "The policy rule for the policy definition. This is a JSON object representing the rule that contains an if and a then block. Omitting this assumes the rules are located in the policy file"
  default     = null
}

variable "policy_parameters" {
  type        = any
  description = "Parameters for the policy definition. This field is a JSON object representing the parameters of your policy definition. Omitting this assumes the parameters are located in the policy file"
  default     = null
}

variable "policy_metadata" {
  type        = any
  description = "The metadata for the policy definition. This is a JSON object representing additional metadata that should be stored with the policy definition. Omitting this will fallback to meta in the definition or merge var.policy_category and var.policy_version"
  default     = null
}

variable "file_path" {
  type        = any
  description = "The filepath to the custom policy. Omitting this assumes the policy is located in the module library"
  default     = null
}

locals {
  # import the custom policy object from a library or specified file path
  policy_object = jsondecode(coalesce(try(
    file(var.file_path),
    file("${path.cwd}/policies/${title(var.policy_category)}/${var.policy_name}.json"),
    file("${path.root}/policies/${title(var.policy_category)}/${var.policy_name}.json"),
    file("${path.root}/../policies/${title(var.policy_category)}/${var.policy_name}.json"),
    file("${path.module}/../../policies/${title(var.policy_category)}/${var.policy_name}.json"),
    "{}" # return empty object if no policy is found
  )))

  # fallbacks
  title    = title(replace(local.policy_name, "/-|_|\\s/", " "))
  category = coalesce(var.policy_category, try((local.policy_object).properties.metadata.category, "General"))
  version  = coalesce(var.policy_version, try((local.policy_object).properties.metadata.version, "1.0.0"))
  mode     = coalesce(var.policy_mode, try((local.policy_object).properties.mode, "All"))

  # use local library attributes if runtime inputs are omitted
  policy_name  = coalesce(var.policy_name, try((local.policy_object).name, null))
  display_name = coalesce(var.display_name, try((local.policy_object).properties.displayName, local.title))
  description  = coalesce(var.policy_description, try((local.policy_object).properties.description, local.title))
  metadata     = coalesce(null, var.policy_metadata, try((local.policy_object).properties.metadata, merge({ category = local.category }, { version = local.version })))
  parameters   = coalesce(null, var.policy_parameters, try((local.policy_object).properties.parameters, {}))
  policy_rule  = coalesce(var.policy_rule, try((local.policy_object).properties.policyRule, null))

  # manually generate the definition Id to prevent "Invalid for_each argument" on set_assignment plan/apply
  definition_id = var.management_group_id != null ? "${var.management_group_id}/providers/Microsoft.Authorization/policyDefinitions/${local.policy_name}" : azurerm_policy_definition.def.id
}
