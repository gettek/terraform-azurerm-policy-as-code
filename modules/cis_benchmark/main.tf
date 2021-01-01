resource azurerm_policy_set_definition cis_benchmark {
  name         = var.name
  display_name = var.display_name
  description  = var.description
  policy_type  = "Custom"

  management_group_name = var.management_group_name

  parameters = local.parameters
  metadata   = local.metadata

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/aa633080-8b72-40c4-a2d7-d00c03e80bed"
    reference_id         = "CISv110x1x1"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9297c21d-2ed6-4474-b48f-163f75654ce3"
    reference_id         = "CISv110x1x1m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e3576e28-8b17-4677-84c3-db2990658d64"
    reference_id         = "CISv110x1x2"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5f76cf89-fbf2-47fd-a3f4-b891fa780b60"
    reference_id         = "CISv110x1x3"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5c607a2e-c700-4744-8254-d77e7c9eb5e4"
    reference_id         = "CISv110x1x3m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f8456c1c-aa66-4dfb-861a-25d127b775c9"
    reference_id         = "CISv110x1x3mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/10ee2ea2-fb4d-45b8-a7e9-a2e770044cd9"
    reference_id         = "CISv110x1x23"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/475aae12-b88a-4572-8b36-9b712b2b3a17"
    reference_id         = "CISv110x2x2"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/86b3d65f-7626-441e-b690-81a8b71cff60"
    reference_id         = "CISv110x2x3CISv110x7x5"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e1e5fd5d-3e4c-4ce1-8661-7d1873ae6b15"
    reference_id         = "CISv110x2x4"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/af6cd1bd-1635-48cb-bde7-5b15693900b9"
    reference_id         = "CISv110x2x5CISv110x7x6"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0961003e-5a0a-4549-abde-af6a37f2724d"
    reference_id         = "CISv110x2x6CISv110x7x1CISv110x7x2"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/08e6af2d-db70-460a-bfe9-d5bd474ba9d6"
    reference_id         = "CISv110x2x7"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e71308d3-144b-4262-b144-efdc3cc90517"
    reference_id         = "CISv110x2x9"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f6de0be7-9a8a-4b8a-b349-43cf02d22f7c"
    reference_id         = "CISv110x2x9m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/760a85ff-6162-42b3-8d70-698e268f648c"
    reference_id         = "CISv110x2x10"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b0f33259-77d7-4c9e-aac6-3aabcfae693c"
    reference_id         = "CISv110x2x12"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/47a6b606-51aa-4496-8bb7-64b11cf66adc"
    reference_id         = "CISv110x2x13"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a6fb4358-5bf4-4ad7-ba82-2cd2f41ce5e9"
    reference_id         = "CISv110x2x14CISv110x4x1"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/17k78e20-9358-41c9-923c-fb736d382a12"
    reference_id         = "CISv110x2x15CISv110x4x9"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/4f4f78b8-e367-4b10-a341-d9a4ad5cf1c7"
    reference_id         = "CISv110x2x16"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b4d66858-c922-44e3-9566-5cdb7a7be744"
    reference_id         = "CISv110x2x17"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/6e2593d9-add6-4083-9c9b-4b7d2188c899"
    reference_id         = "CISv110x2x18"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0b15565f-aa9e-48ba-8619-45960f2c314d"
    reference_id         = "CISv110x2x19"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9"
    reference_id         = "CISv110x3x1"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/34c877ad-507e-4c82-993e-3452a6e0ad3c"
    reference_id         = "CISv110x3x7"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c9d007d0-c057-4772-b18c-01e546713bcd"
    reference_id         = "CISv110x3x8"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7ff426e2-515f-405a-91c8-4f2333442eb5"
    reference_id         = "CISv110x4x2"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/89099bee-89e0-4b26-a5f4-165451757743"
    reference_id         = "CISv110x4x3"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/abfb4388-5bf4-4ad7-ba82-2cd2f41ceae9"
    reference_id         = "CISv110x4x4"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/abfb7388-5bf4-4ad7-ba99-2cd2f41cebb9"
    reference_id         = "CISv110x4x4m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1f314764-cb73-4fc9-b863-8eca98ac36e9"
    reference_id         = "CISv110x4x8"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0d134df8-db83-46fb-ad72-fe0c9428c8dd"
    reference_id         = "CISv110x4x10"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/048248b0-55cd-46da-b1ff-39efd52db260"
    reference_id         = "CISv110x4x10m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e802a67a-daf5-4436-9ea6-f6d821dd0c5d"
    reference_id         = "CISv110x4x11"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/eb6f77b9-bd53-4e35-a23d-7f65d5f0e43d"
    reference_id         = "CISv110x4x12"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/d158790f-bfb0-486c-8631-2dc6b4e8e6af"
    reference_id         = "CISv110x4x13"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/eb6f77b9-bd53-4e35-a23d-7f65d5f0e442"
    reference_id         = "CISv110x4x14"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/eb6f77b9-bd53-4e35-a23d-7f65d5f0e446"
    reference_id         = "CISv110x4x15"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5345bb39-67dc-4960-a1bf-427e16b9a0bd"
    reference_id         = "CISv110x4x17"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7796937f-307b-4598-941c-67d3a05ebfe7"
    reference_id         = "CISv110x5x1x1"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      workspaceRetentionDays = { value = "[parameters('workspaceRetentionDays')]" }
      effect                 = { value = "[parameters('workspaceRetentionEffect')]" }
    })
    policy_definition_id = var.audit_log_analytics_workspace_retention_id
    reference_id         = "CISv110x5x1x2m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1a4e592a-6a6e-44a5-9814-e36264ca96e7"
    reference_id         = "CISv110x5x1x3"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/41388f1c-2db0-4c25-95b2-35d7f5ccbfa9"
    reference_id         = "CISv110x5x1x4"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/fbb99e8e-e444-4da0-9ff1-75c92f5a85b2"
    reference_id         = "CISv110x5x1x6"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/cf820ca0-f99e-4f3e-84fb-66e913812d21"
    reference_id         = "CISv110x5x1x7"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Authorization/policyAssignments/write" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c5447c04-a4d7-4ba8-a263-c9ee321a6858"
    reference_id         = "CISv110x5x2x1"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Network/networkSecurityGroups/write" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b954148f-4c11-4c38-8221-be76711e194a"
    reference_id         = "CISv110x5x2x2"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Network/networkSecurityGroups/delete" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b954148f-4c11-4c38-8221-be76711e194a"
    reference_id         = "CISv110x5x2x3"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Network/networkSecurityGroups/securityRules/write" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b954148f-4c11-4c38-8221-be76711e194a"
    reference_id         = "CISv110x5x2x4"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Network/networkSecurityGroups/securityRules/delete" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b954148f-4c11-4c38-8221-be76711e194a"
    reference_id         = "CISv110x5x2x5"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Security/securitySolutions/write" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3b980d31-7904-4bb7-8575-5665739a8052"
    reference_id         = "CISv110x5x2x6"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Security/securitySolutions/delete" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3b980d31-7904-4bb7-8575-5665739a8052"
    reference_id         = "CISv110x5x2x7"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Sql/servers/firewallRules/write" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b954148f-4c11-4c38-8221-be76711e194a"
    reference_id         = "CISv110x5x2x8"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Sql/servers/firewallRules/delete" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b954148f-4c11-4c38-8221-be76711e194a"
    reference_id         = "CISv110x5x2x8m"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      operationName = { value = "Microsoft.Security/policies/write" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/3b980d31-7904-4bb7-8575-5665739a8052"
    reference_id         = "CISv110x5x2x9"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e372f825-a257-4fb8-9175-797a8a8627d6"
    reference_id         = "CISv110x6x1"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2c89a2e5-7285-40fe-afe0-ae8654b92fab"
    reference_id         = "CISv110x6x2"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      listOfLocations   = { value = "[parameters('listOfRegionsWhereNetworkWatcherShouldBeEnabled')]" },
      resourceGroupName = { value = "[parameters('NetworkWatcherResourceGroupName')]" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/b6e2945c-0b7b-40f5-9233-7a5323b5cdc6"
    reference_id         = "CISv110x6x5"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2c89a2e5-7285-40fe-afe0-ae8654b92fb2"
    reference_id         = "CISv110x7x3"
  }

  policy_definition_reference {
    parameter_values = jsonencode({
      approvedExtensions = { value = "[parameters('listOfApprovedVMExtensions')]" }
    })
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c0e996f8-39cf-4af9-9f45-83fbde810432"
    reference_id         = "CISv110x7x4"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0b60c0b2-2dc2-4e1c-b5c9-abbed971de53"
    reference_id         = "CISv110x8x4"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/ac4a19c2-fa67-49b4-8ae5-0b2e78c49457"
    reference_id         = "CISv110x8x5"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c4ebc54a-46e1-481a-bee2-d4411e95d828"
    reference_id         = "CISv110x9x1"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c75248c1-ea1d-4a9c-8fc9-29a6aabd5da8"
    reference_id         = "CISv110x9x1m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/95bccee9-a7f8-4bec-9ee9-62c3473701fc"
    reference_id         = "CISv110x9x1mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/a4af4a39-4135-47fb-b175-47fbdf85311d"
    reference_id         = "CISv110x9x2"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8cb6aa8b-9e41-4f4e-aa25-089a7ac2581e"
    reference_id         = "CISv110x9x3"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f9d614c5-c173-4d56-95a7-b4437057d193"
    reference_id         = "CISv110x9x3m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/f0e6e85b-9b9f-4a4b-b67b-f730d42f1b0b"
    reference_id         = "CISv110x9x3mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0c192fe8-9cbb-4516-85b3-0ade8bd03886"
    reference_id         = "CISv110x9x4"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/eaebaea7-8013-4ceb-9d14-7eb32271373c"
    reference_id         = "CISv110x9x4m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/5bb220d9-2698-4ee4-8404-b9c30c9df609"
    reference_id         = "CISv110x9x4mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/c4d441f8-f9d9-4a9e-9cef-e82117cb3eef"
    reference_id         = "CISv110x9x5"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/0da106f2-4ca3-48e8-bc85-c638fe6aea8f"
    reference_id         = "CISv110x9x5m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/2b9ad585-36bc-4615-b300-fd4435808332"
    reference_id         = "CISv110x9x5mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/1bc1795e-d44a-4d48-9b3b-6fff0fd5f9ba"
    reference_id         = "CISv110x9x7"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7261b898-8a84-4db8-9e04-18527132abb3"
    reference_id         = "CISv110x9x7mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/74c3584d-afae-46f7-a20a-6f8adba71a16"
    reference_id         = "CISv110x9x8"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7238174a-fd10-4ef0-817e-fc820a951d73"
    reference_id         = "CISv110x9x8m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/7008174a-fd10-4ef0-817e-fc820a951d73"
    reference_id         = "CISv110x9x8mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/88999f4c-376a-45c8-bcb3-4058f713cf39"
    reference_id         = "CISv110x9x9"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/9d0b6ea4-93e2-4578-bf2f-6bb17d22b4bc"
    reference_id         = "CISv110x9x9m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/496223c3-ad65-4ecd-878a-bae78737e9ed"
    reference_id         = "CISv110x9x9mm"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/991310cd-e9f3-47bc-b7b6-f57b557d07db"
    reference_id         = "CISv110x9x10"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/e2c1c086-2d84-4019-bff3-c44ccd95113c"
    reference_id         = "CISv110x9x10m"
  }

  policy_definition_reference {
    policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/8c122334-9d20-4eb8-89ea-ac9a705b74ae"
    reference_id         = "CISv110x9x10mm"
  }
}
