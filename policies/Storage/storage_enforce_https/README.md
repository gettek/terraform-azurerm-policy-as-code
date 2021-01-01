# Enforce HTTPS on Storage Accounts

## Display Name

Secure transfer to storage accounts should be enabled

## Mode

`Indexed`

## Description

Audit requirement of Secure transfer in your storage account. Secure transfer is an option that forces your storage account to accept requests only from secure connections (HTTPS). Use of HTTPS ensures authentication between the server and the service and protects data in transit from network layer attacks such as man-in-the-middle, eavesdropping, and session-hijacking

## Built-In Reference

Modified from: [Storage_AuditForHTTPSEnabled_Audit](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policyDefinitions/Storage/Storage_AuditForHTTPSEnabled_Audit.json)