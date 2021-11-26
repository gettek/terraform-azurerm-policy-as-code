
<#PSScriptInfo

.VERSION 0.2.0

.GUID a38fa39f-f93d-4cf4-9e08-fa8f880e6187

.AUTHOR Michael Greene

.COMPANYNAME Microsoft

.COPYRIGHT 

.TAGS DSCConfiguration

.LICENSEURI https://github.com/Microsoft/WindowsIISServerConfig/blob/master/LICENSE

.PROJECTURI https://github.com/Microsoft/WindowsIISServerConfig

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES
https://github.com/Microsoft/WindowsIISServerConfig/blob/master/README.md#releasenotes

.PRIVATEDATA 2016-Datacenter-Server-Core

#>

#Requires -Module @{modulename = 'xWebAdministration'; moduleversion = '3.2.0'}

<# 

.DESCRIPTION 
 PowerShell Desired State Configuration for deploying and configuring IIS Servers 

#> 

Configuration WindowsIISServerConfig
{
    param
    (
        # Target nodes to apply the configuration
        [String[]] $NodeName = 'localhost'
    )

    Import-DscResource -ModuleName @{ModuleName = 'xWebAdministration'; ModuleVersion = '3.2.0' }
    Import-DscResource -ModuleName 'PSDscResources'

    Node $NodeName
    {
        WindowsFeature WebServer {
            Ensure = 'Present'
            Name   = 'Web-Server'
        }

        # IIS Site Default Values
        xWebSiteDefaults SiteDefaults {
            IsSingleInstance       = 'Yes'
            LogFormat              = 'IIS'
            LogDirectory           = 'C:\inetpub\logs\LogFiles'
            TraceLogDirectory      = 'C:\inetpub\logs\FailedReqLogFiles'
            DefaultApplicationPool = 'DefaultAppPool'
            AllowSubDirConfig      = 'true'
            DependsOn              = '[WindowsFeature]WebServer'
        }

        # IIS App Pool Default Values
        xWebAppPoolDefaults PoolDefaults {
            IsSingleInstance      = 'Yes'
            ManagedRuntimeVersion = 'v4.0'
            IdentityType          = 'ApplicationPoolIdentity'
            DependsOn             = '[WindowsFeature]WebServer'
        }

        <#
    If you would like DSC to deploy your content in to a new site,
    this section provides an example, as well as use of a certificate.

    See more examples in the xWebAdministration resource project.
    https://github.com/PowerShell/xWebAdministration/tree/dev/Examples

     File WebContent
    {
        Ensure          = "Present"
        SourcePath      = $SourcePath
        DestinationPath = $DestinationPath
        Recurse         = $true
        Type            = "Directory"
        DependsOn       = "[WindowsFeature]AspNet45"
    }

    xWebsite NewWebsite
    {
        Ensure          = "Present"
        Name            = $WebSiteName
        State           = "Started"
        PhysicalPath    = $DestinationPath
        DependsOn       = "[File]WebContent"
        BindingInfo     = MSFT_xWebBindingInformation
        {
            Protocol              = 'https'
            Port                  = '443'
            CertificateStoreName  = 'MY'
            CertificateThumbprint = 'BB84DE3EC423DDDE90C08AB3C5A828692089493C'
            HostName              = $Website
            IPAddress             = '*'
            SSLFlags              = '1'
        }
    }
    #>
    }
}
WindowsIISServerConfig