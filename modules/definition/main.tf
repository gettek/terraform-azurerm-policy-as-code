resource azurerm_policy_definition def {
  name         = local.policy_name
  display_name = local.display_name
  description  = local.description
  policy_type  = "Custom"
  mode         = var.policy_mode

  management_group_id = var.management_group_id

  policy_rule = jsonencode(local.policy_rule)
  parameters  = jsonencode(local.parameters)
  metadata    = jsonencode(local.metadata)

  lifecycle {
    create_before_destroy = true
  }

  timeouts {
    read = "10m"
  }
}
