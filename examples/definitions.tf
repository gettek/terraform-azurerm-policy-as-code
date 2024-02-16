##################
# General
##################
module "deny_resource_types" {
  source              = "..//modules/definition"
  policy_name         = "deny_resource_types"
  display_name        = "Deny Azure Resource types"
  policy_category     = "General"
  management_group_id = data.azurerm_management_group.org.id
}

module "whitelist_regions" {
  source              = "..//modules/definition"
  policy_name         = "whitelist_regions"
  display_name        = "Whitelist Azure Regions"
  policy_category     = "General"
  management_group_id = data.azurerm_management_group.org.id
}

##################
# Monitoring
##################

# create definitions by looping around all files found under the Monitoring category folder
module "deploy_resource_diagnostic_setting" {
  source = "..//modules/definition"
  for_each = toset([
    for p in fileset(path.module, "../policies/Monitoring/*.json") :
    trimsuffix(basename(p), ".json")
  ])
  policy_name         = each.key
  policy_category     = "Monitoring"
  management_group_id = data.azurerm_management_group.org.id
}

##################
# Network
##################
module "deny_nic_public_ip" {
  source              = "..//modules/definition"
  policy_name         = "deny_nic_public_ip"
  display_name        = "Network interfaces should not have public IPs"
  policy_category     = "Network"
  management_group_id = data.azurerm_management_group.org.id
}

##################
# Security Center
##################

# create definitions by listing them explicitly
module "configure_asc" {
  source = "..//modules/definition"
  for_each = toset([
    "auto_enroll_subscriptions",
    "auto_provision_log_analytics_agent_custom_workspace",
    "auto_set_contact_details",
    "export_asc_alerts_and_recommendations_to_eventhub",
    "export_asc_alerts_and_recommendations_to_log_analytics",
  ])
  policy_name         = each.value
  policy_category     = "Security Center"
  management_group_id = data.azurerm_management_group.org.id
}

##################
# Storage
##################
module "storage_enforce_https" {
  source              = "..//modules/definition"
  policy_name         = "storage_enforce_https"
  display_name        = "Secure transfer to storage accounts should be enabled"
  policy_category     = "Storage"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.org.id
}

module "storage_enforce_minimum_tls1_2" {
  source              = "..//modules/definition"
  policy_name         = "storage_enforce_minimum_tls1_2"
  display_name        = "Minimum TLS version for data in transit to storage accounts should be set"
  policy_category     = "Storage"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.org.id
}

##################
# Point to a specific filepath
##################
module "file_path_test" {
  source              = "..//modules/definition"
  file_path           = "${path.module}/../policies/Automation/onboard_to_automation_dsc_windows.json"
  management_group_id = data.azurerm_management_group.org.id
}

##################
# Supply some or all policy object properties at runtime
##################
locals {
  policy_file = jsondecode(file("${path.module}/../policies/Automation/onboard_to_automation_dsc_linux.json"))
}

module "parameterised_test" {
  source              = "..//modules/definition"
  policy_name         = "Custom Name"
  display_name        = "Custom Display Name"
  policy_description  = "Custom Description"
  policy_category     = "Custom Category"
  policy_version      = "Custom Version"
  management_group_id = data.azurerm_management_group.org.id

  policy_rule       = (local.policy_file).properties.policyRule
  policy_parameters = (local.policy_file).properties.parameters
  policy_metadata   = (local.policy_file).properties.metadata
}
