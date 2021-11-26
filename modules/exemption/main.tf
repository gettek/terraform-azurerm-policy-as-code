locals {
  exemptions_template = try(templatefile("${path.module}/../policies/exemptions_template.json", {}), {})
  exemptions_parameters = jsonencode({
    exemption_name         = "Public IP Exemption"
    scopes                 = data.azurerm_management_group.team_a.id
    policy_assignment_id   = module.customer_mg_deny_nic_public_ip.id
    exemption_category     = "waiver"
    exemption_display_name = "Exempted for testing"
    exemption_description  = "Exempted for testing"
    requested_by           = "Team A"
    approved_by            = "Mr Smith"
    approved_date          = "01-01-2021"
    ticket_ref             = "99"
  })
}

resource "azurerm_tenant_template_deployment" "policy_exemptions" {
  name = "tls-exemptions"
  parameters_content = { for key, value in local.exemptions_parameters :
    key => merge({ value = value })
  }
  template_content = local.exemptions_template
  deployment_mode  = "Incremental"
}
