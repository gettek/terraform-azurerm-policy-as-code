resource azurerm_policy_assignment def {
  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  scope                = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforcement_mode     = var.assignment_enforcement_mode
  policy_definition_id = var.definition.id
  metadata             = var.definition.metadata
  parameters           = local.parameters
  location             = var.assignment_location

  identity {
    type = local.identity_type
  }
}

resource azurerm_policy_remediation rem {
  count                = local.create_remediation ? 1 : 0
  name                 = lower("${var.definition.name}-${formatdate("DD-MM-YYYY-hh:mm:ss", timestamp())}")
  scope                = var.assignment_scope
  policy_assignment_id = azurerm_policy_assignment.def.id
}
