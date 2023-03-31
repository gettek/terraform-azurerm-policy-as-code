##################
# General
##################
module "org_mg_whitelist_regions" {
  source            = "..//modules/def_assignment"
  definition        = module.whitelist_regions.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "Deny"

  assignment_parameters = {
    listOfRegionsAllowed = [
      "UK South",
      "UK West",
      "Global"
    ]
  }

  assignment_metadata = {
    version   = "1.0.0"
    category  = "Batch"
    propertyA = "A"
    propertyB = "B"
  }
}


##################
# Security Center
##################
module "org_mg_configure_asc_initiative" {
  source                  = "..//modules/set_assignment"
  initiative              = module.configure_asc_initiative.initiative
  assignment_scope        = data.azurerm_management_group.org.id
  assignment_description  = "WIP - Deploys and configures Defender settings and defines exports"
  assignment_effect       = "DeployIfNotExists"
  assignment_location     = "ukwest"
  skip_remediation        = var.skip_remediation
  skip_role_assignment    = var.skip_role_assignment
  resource_discovery_mode = local.resource_discovery_mode

  role_assignment_scope = data.azurerm_management_group.team_a.id # using explicit scopes
  role_definition_ids = [
    data.azurerm_role_definition.contributor.id # using explicit roles
  ]

  assignment_parameters = {
    workspaceId           = local.dummy_resource_ids.azurerm_log_analytics_workspace
    eventHubDetails       = local.dummy_resource_ids.azurerm_eventhub_namespace_authorization_rule
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }

  # optional non-compliance messages. Key/Value pairs map as policy_definition_reference_id = 'content'
  non_compliance_messages = {
    null                    = "The Default non-compliance message for all member definitions"
    AutoEnrollSubscriptions = "The non-compliance message for the auto_enroll_subscriptions definition"
  }
}


##################
# Monitoring
##################
module "org_mg_platform_diagnostics_initiative" {
  source               = "..//modules/set_assignment"
  initiative           = module.platform_diagnostics_initiative.initiative
  assignment_scope     = data.azurerm_management_group.org.id
  skip_remediation     = true
  skip_role_assignment = false

  role_definition_ids = [
    data.azurerm_role_definition.contributor.id # using explicit roles
  ]

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
