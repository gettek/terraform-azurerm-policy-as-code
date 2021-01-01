# Deny Deployment of Public IP's to VM NIC's in a Specific Subnet

## Display Name

Network interfaces in a specified subnet should not have public IPs

## Mode

`Indexed`

## Description

This policy denies the network interfaces which are configured with any public IP on the condition they are attached to a specified subnet based on its suffix. Public IP addresses allow internet resources to communicate inbound to Azure resources, and Azure resources to communicate outbound to the internet. This should be reviewed by the network security team.

## Built-In Reference

Modified from: [Community: deny-nics-from-having-public-ips-when-attached-to-subnets-containing-a-defined-suffix](https://github.com/Azure/Community-Policy/tree/master/Policies/Network/deny-nics-from-having-public-ips-when-attached-to-subnets-containing-a-defined-suffix)
