# Inherit Resource Group Tags Append

## Description

Append a tag and its value from the resource group

## Mode

`Indexed`

## Description

Appends the specified tag with its value from the resource group when any resource which is missing this tag is created or updated. Does not modify the tags of resources created before this policy was applied until those resources are changed. New 'modify' effect policies are available that support remediation of tags on existing resources (see https://aka.ms/modifydoc).

## Built-In Reference

Modified from: [Built-In: InheritTag_Append](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Tags/InheritTag_Append.json)
