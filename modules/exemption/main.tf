resource "azurerm_management_group_policy_exemption" "management_group_exemption" {
  count                           = local.exemption_scope.mg
  name                            = var.name
  display_name                    = var.display_name
  description                     = var.description
  management_group_id             = var.scope
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  expires_on                      = local.expires_on
  policy_definition_reference_ids = local.policy_definition_reference_ids
  metadata                        = local.metadata
}

resource "azurerm_subscription_policy_exemption" "subscription_exemption" {
  count                           = local.exemption_scope.sub
  name                            = var.name
  display_name                    = var.display_name
  description                     = var.description
  subscription_id                 = var.scope
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  expires_on                      = local.expires_on
  policy_definition_reference_ids = local.policy_definition_reference_ids
  metadata                        = local.metadata
}

resource "azurerm_resource_group_policy_exemption" "resource_group_exemption" {
  count                           = local.exemption_scope.rg
  name                            = var.name
  display_name                    = var.display_name
  description                     = var.description
  resource_group_id               = var.scope
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  expires_on                      = local.expires_on
  policy_definition_reference_ids = local.policy_definition_reference_ids
  metadata                        = local.metadata
}

resource "azurerm_resource_policy_exemption" "resource_exemption" {
  count                           = local.exemption_scope.resource
  name                            = var.name
  display_name                    = var.display_name
  description                     = var.description
  resource_id                     = var.scope
  policy_assignment_id            = var.policy_assignment_id
  exemption_category              = var.exemption_category
  expires_on                      = local.expires_on
  policy_definition_reference_ids = local.policy_definition_reference_ids
  metadata                        = local.metadata
}
