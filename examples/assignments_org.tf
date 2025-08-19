##################
# General
##################
module "org_mg_whitelist_regions" {
  source            = "..//modules/def_assignment"
  definition        = module.whitelist_regions.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "Deny"

  assignment_parameters = {
    listOfRegionsAllowed = ["uk", "uksouth", "ukwest", "europe", "northeurope", "westeurope", "global"] # Global is used in services such as Azure DNS
  }

  assignment_metadata = {
    version  = "1.0.0"
    category = "Batch"
    cloud_envs = [
      "AzureCloud",
      "AzureChinaCloud",
      "AzureUSGovernment"
    ]
  }

  # optional resource selectors (preview)
  resource_selectors = [
    {
      name = "SDPRegions"
      selectors = {
        kind = "resourceLocation"
        in   = ["uk", "uksouth", "ukwest"]
      }
    }
  ]
}


##################
# Security Center
##################
module "org_mg_configure_asc_initiative" {
  source                 = "..//modules/set_assignment"
  initiative             = module.configure_asc_initiative.initiative
  assignment_scope       = data.azurerm_management_group.org.id
  assignment_description = "Deploys and configures Defender settings and defines exports"
  assignment_effect      = "DeployIfNotExists"
  assignment_location    = "ukwest"

  # resource remediation options
  re_evaluate_compliance           = var.re_evaluate_compliance
  skip_remediation                 = var.skip_remediation
  skip_role_assignment             = var.skip_role_assignment
  aad_group_remediation_object_ids = [data.azuread_group.rem.object_id] # add assignment identity to aad group(s)

  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }

  # use the `non_compliance_messages` output from the initiative module to set auto generated messages based off policy properties: descriptions/display names/custom ones found in metadata
  # or override with you own Key/Value pairs map e.g. policy_definition_reference_id = 'message content'
  non_compliance_messages = module.configure_asc_initiative.non_compliance_messages

  # optional overrides (preview)
  overrides = [
    {
      effect = "AuditIfNotExists"
      selectors = {
        in = ["export_asc_alerts_and_recommendations_to_eventhub", "export_asc_alerts_and_recommendations_to_log_analytics"]
      }
    }
  ]
}

##################
# Monitoring
##################
module "org_mg_platform_diagnostics_initiative" {
  source           = "..//modules/set_assignment"
  initiative       = module.platform_diagnostics_initiative.initiative
  assignment_scope = data.azurerm_management_group.org.id

  # resource remediation options
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.team_a.id       # set explicit scopes, omit to use the assignment scope
  role_definition_ids    = [data.azurerm_role_definition.contributor.id] # set explicit roles, omit to use roles found in the definitions "policyRule"

  # NOTE: You may omit parameters at assignment to use the definitions 'defaultValue'
  assignment_parameters = {
    workspaceId                                              = local.dummy_resource_ids.azurerm_log_analytics_workspace
    storageAccountId                                         = local.dummy_resource_ids.azurerm_storage_account
    eventHubName                                             = local.dummy_resource_ids.azurerm_eventhub_namespace
    eventHubAuthorizationRuleId                              = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    metricsEnabled                                           = "True"
    logsEnabled                                              = "True"
    effect_deploy_application_gateway_diagnostic_setting     = "DeployIfNotExists"
    effect_deploy_eventhub_diagnostic_setting                = "DeployIfNotExists"
    effect_deploy_expressroute_connection_diagnostic_setting = "DeployIfNotExists"
    effect_deploy_expressroute_diagnostic_setting            = "AuditIfNotExists"
    effect_deploy_firewall_diagnostic_setting                = "AuditIfNotExists"
    effect_deploy_keyvault_diagnostic_setting                = "AuditIfNotExists"
    effect_deploy_loadbalancer_diagnostic_setting            = "AuditIfNotExists"
    effect_deploy_network_interface_diagnostic_setting       = "AuditIfNotExists"
    effect_deploy_network_security_group_diagnostic_setting  = "DeployIfNotExists"
    effect_deploy_public_ip_diagnostic_setting               = "DeployIfNotExists"
    effect_deploy_storage_account_diagnostic_setting         = "AuditIfNotExists"
    effect_deploy_subscription_diagnostic_setting            = "AuditIfNotExists"
    effect_deploy_virtual_machine_diagnostic_setting         = "AuditIfNotExists"
    effect_deploy_vnet_diagnostic_setting                    = "DeployIfNotExists"
    effect_deploy_vnet_gateway_diagnostic_setting            = "AuditIfNotExists"
  }

  non_compliance_messages = module.platform_diagnostics_initiative.non_compliance_messages
}


##################
# Storage
##################
module "org_mg_storage_enforce_https" {
  source            = "..//modules/def_assignment"
  definition        = module.storage_enforce_https.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "Deny"
}

module "org_mg_storage_enforce_minimum_tls1_2" {
  source            = "..//modules/def_assignment"
  definition        = module.storage_enforce_minimum_tls1_2.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "Deny"
}
