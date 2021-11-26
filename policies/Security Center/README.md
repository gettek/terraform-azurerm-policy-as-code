# Security Center Policies

## Description

Automatically enrolls and configures Azure Security Center on every subscription beneath the `assignment_scope`. The assignment managed identity requires the built-in **Contributor** role

## Example Deployment

```hcl
##################
# Security Center
##################

# Definitions (Name and Display Name)
locals {
  security_center_policies = {
    auto_enroll_subscriptions                              = "Enable Azure Security Center on Subcriptions"
    auto_provision_log_analytics_agent_custom_workspace    = "Enable Security Center's auto provisioning of the Log Analytics agent on your subscriptions with custom workspace"
    auto_set_contact_details                               = "Automatically set the security contact email address and phone number should they be blank on the subscription"
    export_asc_alerts_and_recommendations_to_eventhub      = "Export to Event Hub for Azure Security Center alerts and recommendations"
    export_asc_alerts_and_recommendations_to_log_analytics = "Export to Log Analytics Workspace for Azure Security Center alerts and recommendations"
  }
}

module configure_asc {
  source                = "..//modules/definition"
  for_each              = local.security_center_policies
  policy_name           = each.key
  display_name          = each.value
  policy_description    = each.value
  policy_category       = "Security Center"
  management_group_name = data.azurerm_management_group.org.name
}

# Initiative
module configure_asc_initiative {
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

# Assignment
module org_mg_configure_asc_initiative {
  source              = "..//modules/set_assignment"
  initiative          = module.configure_asc_initiative.initiative
  assignment_scope    = data.azurerm_management_group.org.id
  assignment_effect   = "DeployIfNotExists"
  skip_remediation    = var.skip_remediation
  assignment_parameters = {
    workspaceId           = local.logging_law_id
    eventHubDetails       = local.logging_eventhub_namespace_authorization_rule_id
    securityContactsEmail = "admin@cloud.com"
    securityContactsPhone = "44897654987"
  }
}
```
