Configuration WindowsSecurityBaseline2016
{

    Import-DSCResource -ModuleName 'PSDscResources'
    Import-DSCResource -ModuleName 'AuditPolicyDSC'
    Import-DSCResource -ModuleName 'SecurityPolicyDSC'

    Node localhost
    {
        Registry 'Registry(POL): HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client\DisabledByDefault' {
            ValueName = 'DisabledByDefault'
            ValueType = 'Dword'
            Key       = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client'
            ValueData = 1

        }
    }
}
WindowsSecurityBaseline2016