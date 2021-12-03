##################
# Security Center
##################
module "configure_asc_initiative" {
  source                  = "..//modules/initiative"
  initiative_name         = "configure_asc_initiative"
  initiative_display_name = "[Security]: Configure Azure Security Center"
  initiative_description  = "Deploys and configures Azure Security Center settings and defines exports"
  initiative_category     = "Security Center"
  management_group_name   = data.azurerm_management_group.org.name

  member_definitions = [
    module.configure_asc["auto_enroll_subscriptions"].definition,
    module.configure_asc["auto_provision_log_analytics_agent_custom_workspace"].definition,
    module.configure_asc["auto_set_contact_details"].definition,
    module.configure_asc["export_asc_alerts_and_recommendations_to_eventhub"].definition,
    module.configure_asc["export_asc_alerts_and_recommendations_to_log_analytics"].definition,
  ]
}

##################
# Monitoring: Resource & Activity Log Forwarders
##################
module "platform_diagnostics_initiative" {
  source                  = "..//modules/initiative"
  initiative_name         = "platform_diagnostics_initiative"
  initiative_display_name = "[Platform]: Diagnostics Settings Policy Initiative"
  initiative_description  = "Collection of policies that deploy resource and activity log forwarders to logging core resources"
  initiative_category     = "Monitoring"
  management_group_name   = data.azurerm_management_group.org.name

  member_definitions = [
    module.deploy_subscription_diagnostic_setting.definition,
    module.deploy_resource_diagnostic_setting["deploy_eventhub_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_firewall_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_keyvault_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_loadbalancer_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_network_interface_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_network_security_group_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_public_ip_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_vnet_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_vnet_gateway_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_application_gateway_diagnostic_setting"].definition,
    module.deploy_resource_diagnostic_setting["deploy_storage_account_diagnostic_setting"].definition,
  ]
}
