# Deploy Azure Security Center

## Display Name

Enable Azure Security Center on Subcriptions

## Mode

`All`

## Description

Identifies existing subscriptions that are not monitored by Azure Security Center (ASC). Subscriptions not monitored by ASC will be registered to the standard pricing tier. Subscriptions already monitored by ASC (standard), will be considered compliant. To register newly created subscriptions, open the compliance tab, select the relevant non-compliant assignment and create a remediation task. Repeat this step when you have one or more new subscriptions you want to monitor with Security Center.


## Built-In Reference

Modified from: [Built-In Samples: ASC_Register_To_Azure_Security_Center_Deploy.json](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Security%20Center/ASC_Register_To_Azure_Security_Center_Deploy.json)

# Examples

## Assignment
```hcl
module org_mg_auto_enrol_azure_security_center {
  source            = "..//modules/def_assignment"
  definition        = module.auto_enrol_azure_security_center.definition
  assignment_scope  = data.azurerm_management_group.org.id
  assignment_effect = "DeployIfNotExists"
}
```
