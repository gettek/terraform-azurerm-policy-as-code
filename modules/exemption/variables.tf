variable name {
  type        = string
  description = "Name for the Policy Exemption"
}

variable scope {
  type        = string
  description = "Scope for the Policy Exemption"
  default     = ""
}

variable location {
  type        = string
  description = "The Azure Region where the Management Group or Subscription Scope Template Deployment should exist. Changing this forces a new Template to be created. Defaults to UK South"
  default     = "uksouth"
}

variable policy_assignment_id {
  type        = string
  description = "The ID of the policy assignment that is being exempted"
}

variable policy_definition_reference_ids {
  type        = list
  description = "The policy definition reference ID list when the associated policy assignment is an assignment of a policy set definition"
  default     = []
}

variable exemption_category {
  type        = string
  description = "The policy exemption category. Possible values are Waiver or Mitigated. Defaults to Waiver"
  default     = "Waiver"

  validation {
    condition     = var.exemption_category == "Waiver" || var.exemption_category == "Mitigated"
    error_message = "Exemption category possible values are: Waiver or Mitigated."
  }
}

variable expires_on {
  type        = string
  description = "The expiration date and time (in UTC ISO 8601 format yyyy-MM-ddTHH:mm:ssZ) of the policy exemption"
}

variable display_name {
  type        = string
  description = "Display name for the Policy Exemption"
}

variable description {
  type        = string
  description = "Description for the Policy Exemption"
}

variable metadata {
  type        = any
  description = "Optional policy exemption metadata. For example but not limited to; requestedBy, approvedBy, approvedOn, ticketRef, etc"
  default     = {}
}

locals {
  exemptions_template = file("${path.module}/exemptions.json")

  exemption_scope = try({
    mg = length(regexall("(\\/managementGroups\\/)", var.scope)) > 0 ? 1 : 0,
    sub = length(split("/", var.scope)) == 3 ? 1 : 0,
    rg = length(regexall("(\\/managementGroups\\/)", var.scope)) < 1 ? length(split("/", var.scope)) == 5 ? 1 : 0 : 0,
    resource = length(split("/", var.scope)) >= 6 ? 1 : 0,
  })

  parameters_content = {
    name                         = { value = var.name }
    scope                        = { value = local.exemption_scope.mg + local.exemption_scope.sub > 0 ? "" : var.scope }
    policyAssignmentId           = { value = var.policy_assignment_id }
    policyDefinitionReferenceIds = { value = var.policy_definition_reference_ids }
    exemptionCategory            = { value = var.exemption_category }
    expiresOn                    = { value = var.expires_on }
    displayName                  = { value = var.display_name }
    description                  = { value = var.description }
    metadata                     = { value = var.metadata }
  }

  deployment_name = (replace(local.parameters_content.name.value, " ", "_"))

  exemption_resource_node = try(
    azurerm_management_group_template_deployment.management_group_exemption[0],
    azurerm_subscription_template_deployment.subscription_exemption[0],
    azurerm_resource_group_template_deployment.resource_group_exemption[0],
    azurerm_resource_group_template_deployment.resource_exemption[0],
    "")
}
