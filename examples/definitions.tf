##################
# General
##################
module "deny_resources_types" {
  source              = "..//modules/definition"
  policy_name         = "deny_resources_types"
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
module "deploy_subscription_diagnostic_setting" {
  source              = "..//modules/definition"
  policy_name         = "deploy_subscription_diagnostic_setting"
  display_name        = "Deploy Subscription Diagnostic Setting Forwarders"
  policy_category     = "Monitoring"
  management_group_id = data.azurerm_management_group.org.id
}

locals {
  resource_diagnostic_policies = [
    "deploy_application_gateway_diagnostic_setting",
    "deploy_eventhub_diagnostic_setting",
    "deploy_expressroute_connection_diagnostic_setting",
    "deploy_expressroute_diagnostic_setting",
    "deploy_firewall_diagnostic_setting",
    "deploy_keyvault_diagnostic_setting",
    "deploy_loadbalancer_diagnostic_setting",
    "deploy_network_interface_diagnostic_setting",
    "deploy_network_security_group_diagnostic_setting",
    "deploy_public_ip_diagnostic_setting",
    "deploy_storage_account_diagnostic_setting",
    "deploy_vnet_diagnostic_setting",
    "deploy_vnet_gateway_diagnostic_setting"
  ]
}

module "deploy_resource_diagnostic_setting" {
  source              = "..//modules/definition"
  for_each            = toset(local.resource_diagnostic_policies)
  policy_name         = each.value
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
locals {
  security_center_policies = [
    "auto_enroll_subscriptions",
    "auto_provision_log_analytics_agent_custom_workspace",
    "auto_set_contact_details",
    "export_asc_alerts_and_recommendations_to_eventhub",
    "export_asc_alerts_and_recommendations_to_log_analytics",
  ]
}

module "configure_asc" {
  source              = "..//modules/definition"
  for_each            = toset(local.security_center_policies)
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
# Tags
##################

module "inherit_resource_group_tags_modify" {
  source              = "..//modules/definition"
  policy_name         = "inherit_resource_group_tags_modify"
  display_name        = "Resources should inherit Resource Group Tags and Values with Modify Remediation"
  policy_category     = "Tags"
  policy_mode         = "Indexed"
  management_group_id = data.azurerm_management_group.org.id
}
