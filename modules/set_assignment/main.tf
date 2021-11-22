resource azurerm_management_group_policy_assignment set {
  count                = local.assignment_scope.mg
  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  management_group_id  = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource azurerm_subscription_policy_assignment set {
  count                = local.assignment_scope.sub
  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  subscription_id      = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}


resource azurerm_resource_group_policy_assignment set {
  count                = local.assignment_scope.rg
  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  resource_group_id    = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource azurerm_resource_policy_assignment set {
  count                = local.assignment_scope.resource
  name                 = local.assignment_name
  display_name         = local.display_name
  description          = local.description
  resource_id          = var.assignment_scope
  not_scopes           = var.assignment_not_scopes
  enforce              = var.assignment_enforcement_mode
  policy_definition_id = var.initiative.id
  parameters           = local.parameters
  location             = var.assignment_location

  dynamic "identity" {
    for_each = local.identity_type
    content {
      type = identity.value
    }
  }
  
  lifecycle {
    create_before_destroy = true
  }
}

resource azurerm_role_assignment rem_role {
  for_each                         = toset(local.role_definition_ids)
  scope                            = local.role_assignment_scope
  role_definition_id               = each.value
  principal_id                     = local.principal_id
  skip_service_principal_aad_check = true
}

resource azurerm_policy_remediation rem {
  for_each                       = { for dr in local.definition_reference : basename(dr.policy_definition_id) => dr }
  name                           = lower("${each.key}-${formatdate("DD-MM-YYYY-hh:mm:ss", timestamp())}")
  scope                          = var.assignment_scope
  policy_assignment_id           = local.assignment_id
  policy_definition_reference_id = each.value.reference_id
  resource_discovery_mode        = var.resource_discovery_mode
  location_filters               = var.location_filters

  depends_on = [azurerm_role_assignment.rem_role]
}
