##################
# CIS Custom Benchmark
##################
module cis_custom_benchmark {
  source                = "..//modules/cis_benchmark"
  name                  = "cis_custom_benchmark"
  display_name          = "[Security]: CIS Custom Benchmark"
  description           = "Subset of CIS definitions based on CISO requirements"
  management_group_name = azurerm_management_group.org.name

  audit_log_analytics_workspace_retention_id = module.audit_log_analytics_workspace_retention.id
}


##################
# Monitoring: Resource & Activity Log Forwarders
##################
module platform_diagnostics_initiative {
  source                  = "..//modules/initiative"
  initiative_name         = "platform_diagnostics_initiative"
  initiative_display_name = "[Platform]: Diagnostics Settings Policy Initiative"
  initiative_description  = "Collection of policies that deploy resource and activity log forwarders to logging core resources"
  initiative_category     = "Monitoring"
  management_group_name   = azurerm_management_group.org.name

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
