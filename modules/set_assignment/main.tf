resource azurerm_policy_assignment set {
  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  scope                = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforcement_mode     = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  metadata             = var.initiative.metadata
  parameters           = local.parameters
  location             = var.assignment_location

  identity {
    type = local.identity_type
  }

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      metadata
    ]
  }
}

resource azurerm_policy_remediation rem {
  for_each                       = { for dr in local.definition_reference : basename(dr.policy_definition_id) => dr }
  name                           = lower("${each.key}-${formatdate("DD-MM-YYYY-hh:mm:ss", timestamp())}")
  scope                          = var.assignment_scope
  policy_assignment_id           = azurerm_policy_assignment.set.id
  policy_definition_reference_id = each.value.reference_id

  depends_on = [ azurerm_policy_assignment.set ]
}
