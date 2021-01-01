# Deny Deployment of Public IP's to VM NIC's

## Display Name

Network interfaces should not have public IPs

## Mode

`Indexed`

## Description

This policy denies the network interfaces which are configured with any public IP. Public IP addresses allow internet resources to communicate inbound to Azure resources, and Azure resources to communicate outbound to the internet. This should be reviewed by the network security team.

## Built-In Reference

Modified from: [Built-In: NetworkPublicIPNic_Deny](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Network/NetworkPublicIPNic_Deny.json)
