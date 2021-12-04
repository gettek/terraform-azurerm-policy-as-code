variable management_group_name {
  type        = string
  description = "The management group scope at which the policy will be defined. Changing this forces a new resource to be created."
  default     = null
}

variable policy_name {
  type        = string
  description = "Name to be used for this policy, this should correspond to the correct category folder under /policies/policy_category/policy_name if using local policies. Changing this forces a new resource to be created."
}

variable display_name {
  type        = string
  description = "Display Name to be used for this policy"
  default     = null
}

variable policy_description {
  type        = string
  description = "Policy definition description"
  default     = null
}

variable policy_mode {
  type        = string
  description = "The policy mode that allows you to specify which resource types will be evaluated, defaults to All. Possible values are All, Indexed, Microsoft.ContainerService.Data, Microsoft.CustomerLockbox.Data, Microsoft.DataCatalog.Data, Microsoft.KeyVault.Data, Microsoft.Kubernetes.Data, Microsoft.MachineLearningServices.Data, Microsoft.Network.Data and Microsoft.Synapse.Data"
  default     = "All"
}

variable policy_category {
  type        = string
  description = "The category of the policy, should correspond to the correct category folder under /policies/policy_category"
}

variable policy_version {
  type        = string
  description = "The version for this policy, defaults to 1.0.0"
  default     = "1.0.0"
}

variable policy_rule {
  type        = any
  description = "The policy rule for the policy definition. This is a JSON string representing the rule that contains an if and a then block. Omitting this assumes the file is located at /policies/var.policy_category/var.policy_name/rules.json/"
  default     = null
}

variable policy_parameters {
  type        = any
  description = "Parameters for the policy definition. This field is a JSON string that allows you to parameterise your policy definition. Omitting this assumes the file is located at /policies/var.policy_category/var.policy_name/parameters.json"
  default     = null
}

variable policy_metadata {
  type        = any
  description = "The metadata for the policy definition. This is a JSON string representing additional metadata that should be stored with the policy definition. Omitting this will merge var.policy_category and var.policy_version as the metadata"
  default     = null
}

locals {
  policy_object = try(templatefile("${path.module}/../../policies/${title(var.policy_category)}/${var.policy_name}.json", {}), {})

  # use local library attributes if runtime vars omitted
  display_name = var.display_name == null ? try(jsondecode(local.policy_object).properties.displayName, "") : title(replace(var.policy_name, "_", " "))
  description = var.policy_description == null ? try(jsondecode(local.policy_object).properties.description, "") : var.policy_description
  policy_rule = var.policy_rule == null ? jsondecode(local.policy_object).properties.policyRule : var.policy_rule
  parameters = var.policy_parameters == null ? jsondecode(local.policy_object).properties.parameters : var.policy_parameters

  # create metadata if var.policy_metadata is omitted
  metadata = var.policy_metadata == null ? jsonencode(merge(
    { category = var.policy_category },
    { version = var.policy_version },
  )) : var.policy_metadata
}
