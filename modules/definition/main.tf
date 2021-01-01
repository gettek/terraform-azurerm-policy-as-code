resource azurerm_policy_definition def {
  name         = var.policy_name
  display_name = var.display_name
  description  = var.policy_description
  policy_type  = "Custom"
  mode         = var.policy_mode

  management_group_name = var.management_group_name

  policy_rule = local.policy_rule
  parameters  = local.parameters
  metadata    = local.metadata

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      metadata
    ]
  }

  timeouts {
    read = "10m"
  }
}
