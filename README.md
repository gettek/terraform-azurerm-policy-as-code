<!-- markdownlint-configure-file { "MD004": { "style": "consistent" } } -->
<!-- markdownlint-disable MD033 -->
<p align="center">
  <a href="https://docs.microsoft.com/en-us/azure/governance/policy/">
      <img src="img/logo.svg" width="600" alt="Terraform-Azure-Policy-as-Code">
  </a>
  <br>
  <h1 align="center">Azure Policy as Code with Terraform</h1>
  <p align="center">
    <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-orange.svg" alt="MIT License"></a>
    <a href="https://registry.terraform.io/modules/gettek/policy-as-code/azurerm/"><img src="https://img.shields.io/badge/terraform-registry-blue.svg" alt="TF Registry"></a>
  </p>
</p>
<!-- markdownlint-enable MD033 -->

- [Repo Folder Structure](#repo-folder-structure)
- [Policy Definitions Module](#policy-definitions-module)
- [Policy Initiative (Set Definitions) Module](#policy-initiative-set-definitions-module)
- [Policy Assignments](#policy-assignments)
  - [Assignment Effects](#assignment-effects)
  - [Automate Remediation Tasks](#automate-remediation-tasks)
- [Creating Custom Versions of Built-In Policies](#creating-custom-versions-of-built-in-policies)
  - [Sourcing Versions of Builtin Policies](#sourcing-versions-of-builtin-policies)
  - [Sourcing Versions of Custom Policies](#sourcing-versions-of-custom-policies)
- [Definition and Assignment Scopes](#definition-and-assignment-scopes)
- [Limitations](#limitations)
- [Useful Resources](#useful-resources)

## Repo Folder Structure

```bash
📦examples
  ├──📜assignments_mg.tf
  ├──📜backend.tf
  ├──📜data.tf
  ├──📜definitions.tf
  ├──📜initiatives.tf
  ├──📜management_groups.tf
  ├──📜variables.tf
📦modules
  └──📂def_assignment
      ├──📜main.tf
      ├──📜outputs.tf
      └──📜variables.tf
  └──📂definition
      ├──📜data.tf
      ├──📜main.tf
      ├──📜outputs.tf
      └──📜variables.tf
  └──📂initiative
      ├──📜data.tf
      ├──📜main.tf
      ├──📜outputs.tf
      └──📜variables.tf
  └──📂set_assignment
      ├──📜main.tf
      ├──📜outputs.tf
      └──📜variables.tf
📦policies
  └──📂policy_category (e.g. General, should correspond to [var.policy_category])
      └──📂policy_name (e.g. whitelist_regions, should correspond to [var.policy_name])
          ├──📜parameters.json
          └──📜rules.json
```

## Policy Definitions Module

```hcl
module whitelist_regions {
  source                = "gettek/policy-as-code/azurerm//modules/definition"
  version               = "1.2.0"
  policy_name           = "whitelist_regions"
  display_name          = "Allow resources only in whitelisted regions"
  policy_category       = "General"
  management_group_name = local.default_management_group_scope_name
}
```

> :bulb: **Note:** `policy_name` should match the subfolder name containing the **rules** and **parameters** JSON files. The module assumes that `policy_category` is also the category folder name which is a child of the **policies** folder. Template files can also be parsed in at runtime, see the [definition module readme](modules/definition/README.md) for more information on acceptable inputs.

> :bulb: **Note:** Specify the `policy_mode` variable if you wish to [change the mode](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure#mode) of a definition from the module default `All` to `Indexed`.

> :information_source: [Microsoft Docs: Azure Policy definition structure](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/definition-structure)
> 
> :information_source: [Microsoft Docs: Author policies for array properties on Azure resources](https://docs.microsoft.com/en-us/azure/governance/policy/how-to/author-policies-for-arrays)

## Policy Initiative (Set Definitions) Module

Policy Initiatives are used to combine sets of definitions in order to simplify their assignment

```hcl
module platform_baseline_initiative {
  source                  = "gettek/policy-as-code/azurerm//modules/initiative"
  version                 = "1.2.0"
  initiative_name         = "platform_baseline_initiative"
  initiative_display_name = "[Platform]: Baseline Policy Set"
  initiative_description  = "Collection of policies representing the baseline platform requirements"
  initiative_category     = "General"
  management_group_name   = local.default_management_group_scope_name

  member_definition_ids = [ 
    module.whitelist_resources.definition,
    module.whitelist_regions.definition
  ]
}
```

> :warning: **Warning:** If any two `member_definition_ids` contain the same parameters then they will be `merged()` by this module, in most cases this is beneficial but if unique values are required it may be best practice to set unique keys such as `[parameters('whitelist_resources_effect')]` instead of `[parameters('effect')]`.

> :information_source: **Note:** It appears the current `azurerm` provider can only define the initiative at a management group level (or possibly at the default subscription level) - [See GitHub Issue](https://github.com/terraform-providers/terraform-provider-azurerm/issues/5042)

## Policy Assignments

```hcl
module org_mg_whitelist_regions {
  source                = "gettek/policy-as-code/azurerm//modules/def_assignment"
  version               = "1.2.0"
  definition            = module.whitelist_regions.definition
  assignment_scope      = local.default_assignment_scope
  assignment_effect     = "Deny"
  assignment_parameters = {
    "listOfRegionsAllowed" = [
      "UK South",
      "UK West",
      "Global"
    ]
  }
}
```

### Assignment Effects

Azure Policy supports the following types of effect:

![Types Policy Effects from least to most restrictive](img/effects.svg)

> :bulb: **Note:** If you're managing tags, it's recommended to use `Modify` instead of `Append` as Modify provides additional operation types and the ability to remediate existing resources. However, Append is recommended if you aren't able to create a managed identity or Modify doesn't yet support the alias for the resource property.

> :information_source: [Microsoft Docs: Understand how effects work](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/effects)

### Automate Remediation Tasks

The `def_assignment` and `set_assignment` modules will automatically create [remediation tasks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_remediation) for policies with effects of `DeployIfNotExists` and `Modify`. The task name is suffixed with a timestamp to ensure a new task gets created on each `terraform apply`. This can be prevented with `-TF_VAR_skip_remediation=true`.

> :bulb: **Note:** To fully automate remediation tasks without manual intervention via the portal, it may be necessary in some instances to create custom role defenitions. This is a disadvantage by design as identified [in this GitHub issue](https://github.com/Azure/azure-powershell/issues/10196). However an example custom role definition [as seen here](policies/Monitoring/deploy_subscription_diagnostic_setting/README.md#cross-subscription-role-assignment) can be used by the system assigned managed identity, created by the policy assignment, to remediate cross-subscription activity log forwarders.

## Creating Custom Versions of Built-In Policies

It is possible to reference the json of a built-in definition using the [Terraform data source](https://www.terraform.io/docs/providers/azurerm/d/policy_definition.html), this will improve the amount of copy/past but potentially impose a risk if Microsoft release a breaking change. This is how one could modify the effect of a policy without having a its rules copied into a separate JSON file.

```hcl
data azurerm_policy_definition allowed_resource_types {
  display_name = "Allowed resource types"
}

resource azurerm_policy_definition allowed_resource_types {
  name                = "platform-policy-name-here"
  display_name        = "[Platform]: Policy Display Name"
  description         = "Policy Description"
  policy_type         = "Custom"
  mode                = "All"
  management_group_id = var.governance_management_group_id

  lifecycle {
    create_before_destroy = true
    ignore_changes = [
      metadata,
    ]
  }

  parameters  = data.azurerm_policy_definition.allowed_resource_types.parameters
  metadata    = data.azurerm_policy_definition.allowed_resource_types.metadata
  policy_rule = replace(data.azurerm_policy_definition.allowed_resource_types.policy_rule, "\"effect\":\"deny\"", "\"effect\":\"audit\"")
}
```

### Sourcing Versions of Builtin Policies

Currently there is no obvious way of targeting specific [versions of Builtin Policies](https://docs.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies) as this is stored as `metadata` in the form of a single object such as the output below and not a collection of historical tags.

```hcl
output builtin_policy_metadata {
  value = data.azurerm_policy_definition.builtin_policy.metadata
}
```
`Output: builtin_policy_metadata = {"category":"Tags","version":"2.0.0"}`


### Sourcing Versions of Custom Policies

To source a policy module (or any module in fact) that lives in a directory of the same repo use the format below

```hcl
module from_mono_repo {
  source = "git::ssh://.../<org>/<repo>.git//<my_module_dir>"
  ...
}

module from_mono_repo_with_tags {
   source = "git::ssh://..../<org>/<repo>.git//<my_module_dir>?ref=1.2.3"
   ...
}
```

## Definition and Assignment Scopes

  - Should be Defined as **high up** in the hierarchy as possible
  - Should be Assigned as **low down** in the hierarchy as possible
  - `assignment_not_scopes` such as child resource groups, individual resources or entire subscriptions, can be specified as enforcement exemptions
  - Policy **overrides RBAC** so even Subscription owners fall under the same compliance enforcements assigned at a higher scope

![Policy Definition and Assignment Scopes](img/scopes.svg)

> :warning: **Requirement:** Ensure the deployment account has at least [Resource Policy Contributor](https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#resource-policy-contributor) role at the `definition_scope` and `assignment_scope`

## Limitations

- `DefinitionName` has a maximum length of **64** characters and `AssignmentName` a maximum length of **24** characters
- `DisplayName` has a maximum length of **128** characters and `description` a maximum length of **512** characters
- There's a [maximum count](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/azure-subscription-service-limits#azure-policy-limits) for each object type for Azure Policy. For definitions, an entry of Scope means the management group or subscription. For assignments and exemptions, an entry of Scope means the management group, subscription, resource group, or individual resource:

| Where                            | What                               | Maximum count |
|----------------------------------|------------------------------------|---------------|
| Scope                            | Policy   definitions               | 500           |
| Scope                            | Initiative   definitions           | 200           |
| Tenant                           | Initiative   definitions           | 2,500         |
| Scope                            | Policy   or initiative assignments | 200           |
| Scope                            | Exemptions                         | 1000          |
| Policy definition                | Parameters                         | 20            |
| Initiative definition            | Policies                           | 1000          |
| Initiative definition            | Parameters                         | 100           |
| Policy or initiative assignments | Exclusions   (notScopes)           | 400           |
| Policy rule                      | Nested   conditionals              | 512           |
| Remediation task                 | Resources                          | 500           |


## Useful Resources

- [GitHub Repo: Azure Built-In Policies and Samples](https://github.com/Azure/azure-policy)
- [GitHub Repo: Contribute to Community Policies](https://github.com/Azure/Community-Policy)
- [Microsoft Docs: Azure Policy Home](https://docs.microsoft.com/en-us/azure/governance/policy/)
- [Microsoft Docs: List of Builtin Policies](https://docs.microsoft.com/en-us/azure/governance/policy/samples/built-in-policies)
- [Microsoft Docs: Index of Azure Policy Samples](https://docs.microsoft.com/en-us/azure/governance/policy/samples/)
- [Microsoft Docs: Design Azure Policy as Code workflows](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/policy-as-code)
- [Microsoft Docs: Evaluate the impact of a new Azure Policy definition](https://docs.microsoft.com/en-us/azure/governance/policy/concepts/evaluate-impact)
- [Microsoft Docs: Azure Policy Regulatory Compliance (Benchmarks)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/security-controls-policy)
- [Microsoft Docs: Azure Policy Exemption (preview)](https://docs.microsoft.com/en-gb/azure/governance/policy/concepts/exemption-structure)
- [Microsoft Tutorial: Build policies to enforce compliance](https://docs.microsoft.com/en-us/azure/governance/policy/tutorials/create-and-manage)
- [Microsoft Tutorial: Security Center - Working with security policies](https://docs.microsoft.com/en-us/azure/security-center/tutorial-security-policy)
- [VSCode Marketplace: Azure Policy Extension](https://marketplace.visualstudio.com/items?itemName=AzurePolicy.azurepolicyextension)
- [Terraform Provider: azurerm_policy_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_definition)
- [Terraform Provider: azurerm_policy_set_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_set_definition)
- [Terraform Provider: azurerm_policy_assignment](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_assignment)
- [Terraform Provider: azurerm_policy_remediation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/policy_remediation)
