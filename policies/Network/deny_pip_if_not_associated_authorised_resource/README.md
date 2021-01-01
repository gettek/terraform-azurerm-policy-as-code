# Deny Public IP if not associated with authorised resources

## Display Name

Public IP addresses should only be created when associated with an Azure Firewall or Virtual Network Gateway.

## Mode

`Indexed`

## Description
This policy denies public IP addresses of being created with the exception of Virtual Network Gateways or Azure Firewalls. 

## Built-In Reference

Modified from: [Built-In: NetworkPublicIPNic_Deny](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Network/NetworkPublicIPNic_Deny.json)
