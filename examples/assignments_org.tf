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
  re_evaluate_compliance = var.re_evaluate_compliance
  skip_remediation       = var.skip_remediation
  skip_role_assignment   = var.skip_role_assignment
  role_assignment_scope  = data.azurerm_management_group.team_a.id # set explicit scopes (defaults to assignment scope)

  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }

  # use the `non_compliance_messages` output from the initiative module to set auto generated messages based off policy properties: descriptions/display names/custom ones found in metadata
  # or overried with you own Key/Value pairs map e.g. policy_definition_reference_id = 'message content'
  non_compliance_messages = module.configure_asc_initiative.non_compliance_messages

  # optional overrides (preview)
  overrides = [
    {
      effect = "AuditIfNotExists"
      selectors = {
        in = ["ExportAscAlertsAndRecommendationsToEventhub", "ExportAscAlertsAndRecommendationsToLogAnalytics"]
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
  role_definition_ids    = [data.azurerm_role_definition.contributor.id] # using explicit roles

  # NOTE: You may omit parameters at assignment to use the definitions 'defaultValue'
  assignment_parameters = {
    workspaceId                                        = local.dummy_resource_ids.azurerm_log_analytics_workspace
    storageAccountId                                   = local.dummy_resource_ids.azurerm_storage_account
    eventHubName                                       = local.dummy_resource_ids.azurerm_eventhub_namespace
    eventHubAuthorizationRuleId                        = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    metricsEnabled                                     = "True"
    logsEnabled                                        = "True"
    effect_DeployApplicationGatewayDiagnosticSetting   = "DeployIfNotExists"
    effect_DeployEventhubDiagnosticSetting             = "DeployIfNotExists"
    effect_DeployFirewallDiagnosticSetting             = "DeployIfNotExists"
    effect_DeployKeyvaultDiagnosticSetting             = "AuditIfNotExists"
    effect_DeployLoadbalancerDiagnosticSetting         = "AuditIfNotExists"
    effect_DeployNetworkInterfaceDiagnosticSetting     = "AuditIfNotExists"
    effect_DeployNetworkSecurityGroupDiagnosticSetting = "AuditIfNotExists"
    effect_DeployPublicIpDiagnosticSetting             = "AuditIfNotExists"
    effect_DeployStorageAccountDiagnosticSetting       = "DeployIfNotExists"
    effect_DeploySubscriptionDiagnosticSetting         = "DeployIfNotExists"
    effect_DeployVnetDiagnosticSetting                 = "AuditIfNotExists"
    effect_DeployVnetGatewayDiagnosticSetting          = "AuditIfNotExists"
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
