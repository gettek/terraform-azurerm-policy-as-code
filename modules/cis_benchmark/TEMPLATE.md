# Custom CIS Benchmark 1.1.0

## Display Name

CIS Microsoft Azure Foundations Custom Benchmark 1.1.0

## Description

This module is created to cover a subset of policies defined in CIS Microsoft Azure Foundations Benchmark 1.1.0 recommendations. 

We do not want to assign the set defined by Azure as it is:
  1. This default set is subject to change and does not give us the control over what we can define/apply.
  2. We might not need to apply the whole set depending on the requirements we have. 
  3. Being able to reference policies through Id's -which is not an option in Terraform- decouples us from the dependency on policy display names.

## Built-In Reference

Modified from: [Built-In: CISv1_1_0_audit](https://github.com/Azure/azure-policy/blob/master/built-in-policies/policySetDefinitions/Regulatory%20Compliance/CISv1_1_0_audit.json)
