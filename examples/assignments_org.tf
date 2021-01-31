##################
# CIS Custom Benchmark
##################

module org_mg_cis_custom_benchmark {
  source           = "..//modules/set_assignment"
  initiative       = module.cis_custom_benchmark.initiative
  assignment_scope = azurerm_management_group.org.id
  assignment_parameters = {
    NetworkWatcherResourceGroupName                 = ""
    listOfApprovedVMExtensions                      = [""]
    listOfRegionsWhereNetworkWatcherShouldBeEnabled = ["uksouth", "ukwest"]
    workspaceRetentionDays                          = 456
    workspaceRetentionEffect                        = "AuditIfNotExists"
  }

  depends_on = [
    module.cis_custom_benchmark
  ]
}


##################
# General
##################

module org_mg_whitelist_regions {
  source            = "..//modules/def_assignment"
  definition        = module.whitelist_regions.definition
  assignment_scope  = azurerm_management_group.org.id
  assignment_effect = "Deny"
  assignment_parameters = {
    "listOfRegionsAllowed" = [
      "UK South",
      "UK West",
      "Global"
    ]
  }
}


##################
# Security Center
##################

module org_mg_configure_asc_initiative {
  source            = "..//modules/set_assignment"
  initiative        = module.configure_asc_initiative.initiative
  assignment_scope  = azurerm_management_group.org.id
  assignment_effect = "DeployIfNotExists"
  skip_remediation  = var.skip_remediation
  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "cisocloud@aviva.com"
    securityContactsPhone = "07700000770"
  }
}

resource azurerm_role_assignment org_mg_configure_asc_initiative {
  count              = var.skip_remediation ? 0 : 1
  scope              = azurerm_management_group.org.id
  role_definition_id = data.azurerm_role_definition.security_admin.id
  principal_id       = module.org_mg_configure_asc_initiative.identity_id
}


##################
# Storage
##################

module org_mg_storage_enforce_https {
  source            = "..//modules/def_assignment"
  definition        = module.storage_enforce_https.definition
  assignment_scope  = azurerm_management_group.org.id
  assignment_effect = "Deny"
}

module org_mg_storage_enforce_minimum_tls1_2 {
  source            = "..//modules/def_assignment"
  definition        = module.storage_enforce_minimum_tls1_2.definition
  assignment_scope  = azurerm_management_group.org.id
  assignment_effect = "Deny"
}

##################
# Network
##################
module org_mg_network_deny_nat_rules_firewall {
  source            = "..//modules/def_assignment"
  definition        = module.deny_nat_rules_firewalls.definition
  assignment_scope  = azurerm_management_group.org.id
  assignment_effect = "Deny"
}

##################
# Monitoring
##################
resource random_uuid org_mg_remediate_platform_diagnostics_initiative {}

resource azurerm_role_definition org_mg_remediate_platform_diagnostic_settings {
  name               = "policy_remediates_platform_diagnostic_settings"
  role_definition_id = random_uuid.org_mg_remediate_platform_diagnostics_initiative.result
  scope              = azurerm_management_group.org.id
  description        = "Enables the managed identity created by policy assignment permissions to remediate non compliant resources"

  permissions {
    actions = [
      "Microsoft.Authorization/*/read",
      "Microsoft.Automation/automationAccounts/*",
      "Microsoft.Compute/virtualMachines/extensions/write",
      "Microsoft.Compute/virtualMachines/extensions/read",
      "Microsoft.EventHub/namespaces/authorizationrules/listkeys/action",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Insights/components/*/read",
      "Microsoft.Insights/alertRules/*",
      "Microsoft.Insights/diagnosticSettings/*",
      "Microsoft.OperationalInsights/*",
      "Microsoft.OperationsManagement/*",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourcegroups/deployments/*",
      "Microsoft.Support/*",
      "Microsoft.Storage/storageAccounts/listKeys/action",
      "Microsoft.Storage/storageAccounts/read",
    ]
  }

  assignable_scopes = [
    azurerm_management_group.org.id
  ]
}

module org_mg_platform_diagnostics_initiative {
  source            = "..//modules/set_assignment"
  initiative        = module.platform_diagnostics_initiative.initiative
  assignment_scope  = azurerm_management_group.org.id
  assignment_effect = "DeployIfNotExists"
  skip_remediation  = var.skip_remediation
  assignment_parameters = {
    workspaceId                 = local.dummy_resource_ids.azurerm_log_analytics_workspace
    storageAccountId            = local.dummy_resource_ids.azurerm_storage_account
    eventHubName                = local.dummy_resource_ids.azurerm_eventhub_namespace
    eventHubAuthorizationRuleId = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    metricsEnabled              = "True"
    logsEnabled                 = "True"
  }

  depends_on = [
    module.deploy_subscription_diagnostic_setting,
    module.deploy_resource_diagnostic_setting
  ]
}

resource azurerm_role_assignment org_mg_remediate_platform_diagnostic_settings {
  count              = var.skip_remediation ? 0 : 1
  scope              = azurerm_management_group.org.id
  role_definition_id = azurerm_role_definition.org_mg_remediate_platform_diagnostic_settings.role_definition_resource_id
  principal_id       = module.org_mg_platform_diagnostics_initiative.identity_id
}


##################
# Tags
##################

resource random_uuid org_mg_add_replace_resource_group_tag_key_modify {}

resource azurerm_role_definition org_mg_add_replace_resource_group_tag_key_modify {
  name               = "policy_remediates_add_replace_resource_group_tags"
  role_definition_id = random_uuid.org_mg_add_replace_resource_group_tag_key_modify.result
  scope              = azurerm_management_group.org.id
  description        = "Enables the managed identity created by policy assignment permissions to remediate non resource group tags"
  permissions {
    actions = [
      "Microsoft.Authorization/*/read",
      "Microsoft.Automation/automationAccounts/*",
      "Microsoft.Resources/deployments/*",
      "Microsoft.Resources/subscriptions/resourceGroups/read",
      "Microsoft.Resources/subscriptions/resourcegroups/deployments/*",
      "Microsoft.Resources/tags/read",
      "Microsoft.Resources/tags/write",
      "Microsoft.Support/*"
    ]
  }
  assignable_scopes = [
    azurerm_management_group.org.id
  ]
}
