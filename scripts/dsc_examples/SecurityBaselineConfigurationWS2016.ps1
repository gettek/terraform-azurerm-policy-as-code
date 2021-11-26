Configuration SecurityBaselineConfigurationWS2016
{

	Import-DSCResource -ModuleName 'PSDscResources'
	Import-DSCResource -ModuleName 'AuditPolicyDSC'
	Import-DSCResource -ModuleName 'SecurityPolicyDSC'
	Node localhost
	{
		Registry "CCE-37615-2: Ensure 'Accounts: Limit local account use of blank passwords to console logon only' is set to 'Enabled'" {
			ValueName = 'LimitBlankPasswordUse'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 1

		}

		Registry "CCE-36254-1: Ensure 'Allow Basic authentication' is set to 'Disabled'" {
			ValueName = 'AllowBasic'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\WinRM\Client'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Allow Cortana above lock screen' is set to 'Disabled'" {
			ValueName = 'AllowCortanaAboveLock'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Allow Cortana' is set to 'Disabled'" {
			ValueName = 'AllowCortana'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search'
			ValueData = 0

		}

		Registry "CCE-38277-0: Ensure 'Allow indexing of encrypted files' is set to 'Disabled'" {
			ValueName = 'AllowIndexingEncryptedStoresOrItems'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Allow Input Personalization' is set to 'Disabled'" {
			ValueName = 'AllowInputPersonalization'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\InputPersonalization'
			ValueData = 0

		}

		Registry "CCE-38354-7: Ensure 'Allow Microsoft accounts to be optional' is set to 'Enabled'" {
			ValueName = 'MSAOptional'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Ensure 'Allow search and Cortana to use location' is set to 'Disabled'" {
			ValueName = 'AllowSearchToUseLocation'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Windows Search'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Allow Telemetry' is set to 'Enabled: 0 - Security [Enterprise Only]'" {
			ValueName = 'AllowTelemetry'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\DataCollection'
			ValueData = 2

		}

		Registry "CCE-38223-4: Ensure 'Allow unencrypted traffic' is set to 'Disabled'" {
			ValueName = 'AllowUnencryptedTraffic'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\WinRM\Client'
			ValueData = 0

		}

		Registry "CCE-36400-0: Ensure 'Allow user control over installs' is set to 'Disabled'" {
			ValueName = 'EnableUserControl'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Installer'
			ValueData = 0

		}

		Registry "CCE-37490-0: Ensure 'Always install with elevated privileges' is set to 'Disabled'" {
			ValueName = 'AlwaysInstallElevated'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Installer'
			ValueData = 0

		}

		Registry "CCE-37929-7: Ensure 'Always prompt for password upon connection' is set to 'Enabled'" {
			ValueName = 'fPromptForPassword'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 1

		}

		Registry "CCE-37775-4: Ensure 'Application: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'" {
			ValueName = 'Retention'
			ValueType = 'String'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\Application'
			ValueData = '0'

		}

		Registry "CCE-37948-7: Ensure 'Application: Specify the maximum log file size ' is set to 'Enabled: 32,768 or greater'" {
			ValueName = 'MaxSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\Application'
			ValueData = 32768

		}

		Registry "CCE-37850-5: Ensure 'Audit: Force audit policy subcategory settings  to override audit policy category settings' is set to 'Enabled'" {
			ValueName = 'SCENoApplyLegacyAuditPolicy'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 1

		}

		Registry "CCE-35907-5: Ensure 'Audit: Shut down system immediately if unable to log security audits' is set to 'Disabled'" {
			ValueName = 'CrashOnAuditFail'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Block user from showing account details on sign-in' is set to 'Enabled'" {
			ValueName = 'BlockUserFromShowingAccountDetailsOnSignin'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 1

		}

		Registry "CCE-37912-3: Ensure 'Boot-Start Driver Initialization Policy' is set to 'Enabled: Good, unknown and bad but critical'" {
			ValueName = 'DriverLoadPolicy'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Policies\EarlyLaunch'
			ValueData = 3

		}

		Registry "CCE-36388-7: Ensure 'Configure Offer Remote Assistance' is set to 'Disabled'" {
			ValueName = 'fAllowUnsolicited'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 0

		}

		Registry "CCE-36169-1: Ensure 'Configure registry policy processing: Do not apply during periodic background processing' is set to 'Enabled: FALSE'" {
			ValueName = 'NoBackgroundPolicy'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
			ValueData = 0

		}

		Registry "CCE-36169-1: Ensure 'Configure registry policy processing: Process even if the Group Policy objects have not changed' is set to 'Enabled: TRUE'" {
			ValueName = 'NoGPOListChanges'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
			ValueData = 0

		}

		Registry "CCE-37281-3: Ensure 'Configure Solicited Remote Assistance' is set to 'Disabled'" {
			ValueName = 'fAllowToGetHelp'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 0

		}

		Registry "CCE-35859-8: Ensure 'Configure Windows SmartScreen' is set to 'Enabled'" {
			ValueName = 'EnableSmartScreen'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Ensure 'Continue experiences on this device' is set to 'Disabled'" {
			ValueName = 'EnableCdp'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 0

		}

		Registry "CCE-37701-0: Ensure 'Devices: Allowed to format and eject removable media' is set to 'Administrators'" {
			ValueName = 'AllocateDASD'
			ValueType = 'String'
			Key       = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'
			ValueData = '0'

		}

		Registry "CCE-37942-0: Ensure 'Devices: Prevent users from installing printer drivers' is set to 'Enabled'" {
			ValueName = 'AddPrinterDrivers'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Print\Providers\LanMan Print Services\Servers'
			ValueData = 1

		}

		Registry "CCE-37636-8: Ensure 'Disallow Autoplay for non-volume devices' is set to 'Enabled'" {
			ValueName = 'NoAutoplayfornonVolume'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Explorer'
			ValueData = 1

		}

		Registry "CCE-38318-2: Ensure 'Disallow Digest authentication' is set to 'Enabled'" {
			ValueName = 'AllowDigest'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\WinRM\Client'
			ValueData = 0

		}

		Registry "CCE-36000-8: Ensure 'Disallow WinRM from storing RunAs credentials' is set to 'Enabled'" {
			ValueName = 'DisableRunAs'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\WinRM\Service'
			ValueData = 1

		}

		Registry "CCE-36223-6: Ensure 'Do not allow passwords to be saved' is set to 'Enabled'" {
			ValueName = 'DisablePasswordSaving'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 1

		}

		Registry "CCE-38353-9: Ensure 'Do not display network selection UI' is set to 'Enabled'" {
			ValueName = 'DontDisplayNetworkSelectionUI'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 1

		}

		Registry "CCE-37534-5: Ensure 'Do not display the password reveal button' is set to 'Enabled'" {
			ValueName = 'DisablePasswordReveal'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\CredUI'
			ValueData = 1

		}

		Registry "CCE-37838-0: Ensure 'Do not enumerate connected users on domain-joined computers' is set to 'Enabled'" {
			ValueName = 'DontEnumerateConnectedUsers'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Do not show feedback notifications' is set to 'Enabled'" {
			ValueName = 'DoNotShowFeedbackNotifications'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\DataCollection'
			ValueData = 1

		}

		Registry "CCE-38180-6: Ensure 'Do not use temporary folders per session' is set to 'Disabled'" {
			ValueName = 'PerSessionTempDir'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 1

		}

		Registry "CCE-36142-8: Ensure 'Domain member: Digitally encrypt or sign secure channel data ' is set to 'Enabled'" {
			ValueName = 'RequireSignOrSeal'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters'
			ValueData = 1

		}

		Registry "CCE-37130-2: Ensure 'Domain member: Digitally encrypt secure channel data ' is set to 'Enabled'" {
			ValueName = 'SealSecureChannel'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters'
			ValueData = 1

		}

		Registry "CCE-37222-7: Ensure 'Domain member: Digitally sign secure channel data (when possible)' is set to 'Enabled'" {
			ValueName = 'SignSecureChannel'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters'
			ValueData = 1

		}

		Registry "CCE-37508-9: Ensure 'Domain member: Disable machine account password changes' is set to 'Disabled'" {
			ValueName = 'DisablePasswordChange'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters'
			ValueData = 0

		}

		Registry "CCE-37431-4: Ensure 'Domain member: Maximum machine account password age' is set to '30 or fewer days, but not 0'" {
			ValueName = 'MaximumPasswordAge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters'
			ValueData = 30

		}

		Registry "CCE-37614-5: Ensure 'Domain member: Require strong  session key' is set to 'Enabled'" {
			ValueName = 'RequireStrongKey'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Netlogon\Parameters'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Ensure 'Enable insecure guest logons' is set to 'Disabled'" {
			ValueName = 'AllowInsecureGuestAuth'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\LanmanWorkstation'
			ValueData = 0

		}

		Registry "CCE-37346-4: Ensure 'Enable RPC Endpoint Mapper Client Authentication' is set to 'Enabled'" {
			ValueName = 'EnableAuthEpResolution'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Rpc'
			ValueData = 1

		}

		Registry "CCE-36512-2: Ensure 'Enumerate administrator accounts on elevation' is set to 'Disabled'" {
			ValueName = 'EnumerateAdministrators'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\CredUI'
			ValueData = 0

		}

		Registry "CCE-35894-5: Ensure 'Enumerate local users on domain-joined computers' is set to 'Disabled'" {
			ValueName = 'EnumerateLocalUsers'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 0

		}

		Registry "CCE-36056-0: Ensure 'Interactive logon: Do not display last user name' is set to 'Enabled'" {
			ValueName = 'DontDisplayLastUserName'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-37637-6: Ensure 'Interactive logon: Do not require CTRL+ALT+DEL' is set to 'Disabled'" {
			ValueName = 'DisableCAD'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 0

		}

		Registry "CCE-36325-9: Ensure 'Microsoft network client: Digitally sign communications (always)' is set to 'Enabled'" {
			ValueName = 'RequireSecuritySignature'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters'
			ValueData = 1

		}

		Registry "CCE-36269-9: Ensure 'Microsoft network client: Digitally sign communications (if server agrees)' is set to 'Enabled'" {
			ValueName = 'EnableSecuritySignature'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters'
			ValueData = 1

		}

		Registry "CCE-37863-8: Ensure 'Microsoft network client: Send unencrypted password to third-party SMB servers' is set to 'Disabled'" {
			ValueName = 'EnablePlainTextPassword'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation\Parameters'
			ValueData = 0

		}

		Registry "CCE-38046-9: Ensure 'Microsoft network server: Amount of idle time required before suspending session' is set to '15 or fewer minute, but not 0'" {
			ValueName = 'AutoDisconnect'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters'
			ValueData = 15

		}

		Registry "CCE-37864-6: Ensure 'Microsoft network server: Digitally sign communications (always)' is set to 'Enabled'" {
			ValueName = 'RequireSecuritySignature'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters'
			ValueData = 1

		}

		Registry "CCE-35988-5: Ensure 'Microsoft network server: Digitally sign communications (if client agrees)' is set to 'Enabled'" {
			ValueName = 'EnableSecuritySignature'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters'
			ValueData = 1

		}

		Registry "CCE-37972-7: Ensure 'Microsoft network server: Disconnect clients when logon hours expire' is set to 'Enabled'" {
			ValueName = 'EnableForcedLogoff'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters'
			ValueData = 1

		}

		Registry "CCE-38338-0: Ensure 'Minimize the number of simultaneous connections to the Internet or a Windows Domain' is set to 'Enabled'" {
			ValueName = 'fMinimizeConnections'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\WcmSvc\GroupPolicy'
			ValueData = 1

		}

		Registry "CCE-36077-6: Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts and shares' is set to 'Enabled'" {
			ValueName = 'RestrictAnonymous'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 1

		}

		Registry "CCE-36316-8: Ensure 'Network access: Do not allow anonymous enumeration of SAM accounts' is set to 'Enabled'" {
			ValueName = 'RestrictAnonymousSAM'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 1

		}

		Registry "CCE-36148-5: Ensure 'Network access: Let Everyone permissions apply to anonymous users' is set to 'Disabled'" {
			ValueName = 'EveryoneIncludesAnonymous'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 0

		}

		Registry "CCE-36021-4: Ensure 'Network access: Restrict anonymous access to Named Pipes and Shares' is set to 'Enabled'" {
			ValueName = 'RestrictNullSessAccess'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Ensure 'Network access: Restrict clients allowed to make remote calls to SAM' is set to 'Administrators: Remote Access: Allow'" {
			ValueName = 'RestrictRemoteSAM'
			ValueType = 'String'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 'O:BAG:BAD:(A;;RC;;;BA)'

		}

		Registry "CCE-38095-6: Ensure 'Network access: Shares that can be accessed anonymously' is set to 'None'" {
			ValueName = 'NullSessionShares'
			ValueType = 'MultiString'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanManServer\Parameters'
			ValueData = '0'

		}

		Registry "CCE-37623-6: Ensure 'Network access: Sharing and security model for local accounts' is set to 'Classic - local users authenticate as themselves'" {
			ValueName = 'ForceGuest'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 0

		}

		Registry "CCE-38341-4: Ensure 'Network security: Allow Local System to use computer identity for NTLM' is set to 'Enabled'" {
			ValueName = 'UseMachineId'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 1

		}

		Registry "CCE-37035-3: Ensure 'Network security: Allow LocalSystem NULL session fallback' is set to 'Disabled'" {
			ValueName = 'AllowNullSessionFallback'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0'
			ValueData = 0

		}

		Registry "CCE-38047-7: Ensure 'Network Security: Allow PKU2U authentication requests to this computer to use online identities' is set to 'Disabled'" {
			ValueName = 'AllowOnlineID'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa\pku2u'
			ValueData = 0

		}

		Registry "CCE-37755-6: Ensure 'Network Security: Configure encryption types allowed for Kerberos' is set to 'RC4_HMAC_MD5, AES128_HMAC_SHA1, AES256_HMAC_SHA1, Future encryption types'" {
			ValueName = 'SupportedEncryptionTypes'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System\Kerberos\Parameters'
			ValueData = 2147483644

		}

		Registry "CCE-36326-7: Ensure 'Network security: Do not store LAN Manager hash value on next password change' is set to 'Enabled'" {
			ValueName = 'NoLMHash'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 1

		}

		Registry "CCE-36173-3: Ensure 'Network security: LAN Manager authentication level' is set to 'Send NTLMv2 response only. Refuse LM & NTLM'" {
			ValueName = 'LmCompatibilityLevel'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa'
			ValueData = 5

		}

		Registry "CCE-36858-9: Ensure 'Network security: LDAP client signing requirements' is set to 'Negotiate signing' or higher" {
			ValueName = 'LDAPClientIntegrity'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LDAP'
			ValueData = 1

		}

		Registry "CCE-37553-5: Ensure 'Network security: Minimum session security for NTLM SSP based  clients' is set to 'Require NTLMv2 session security, Require 128-bit encryption'" {
			ValueName = 'NTLMMinClientSec'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0'
			ValueData = 537395200

		}

		Registry "CCE-37835-6: Ensure 'Network security: Minimum session security for NTLM SSP based  servers' is set to 'Require NTLMv2 session security, Require 128-bit encryption'" {
			ValueName = 'NTLMMinServerSec'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Lsa\MSV1_0'
			ValueData = 537395200

		}

		Registry "CCE-37126-0: Ensure 'Prevent downloading of enclosures' is set to 'Enabled'" {
			ValueName = 'DisableEnclosureDownload'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Internet Explorer\Feeds'
			ValueData = 1

		}

		Registry "CCE-38347-1: Ensure 'Prevent enabling lock screen camera' is set to 'Enabled'" {
			ValueName = 'NoLockScreenCamera'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Personalization'
			ValueData = 1

		}

		Registry "CCE-38348-9: Ensure 'Prevent enabling lock screen slide show' is set to 'Enabled'" {
			ValueName = 'NoLockScreenSlideshow'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Personalization'
			ValueData = 1

		}

		Registry "CCE-38002-2: Ensure 'Prohibit installation and configuration of Network Bridge on your DNS domain network' is set to 'Enabled'" {
			ValueName = 'NC_AllowNetBridge_NLA'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Network Connections'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Prohibit use of Internet Connection Sharing on your DNS domain network' is set to 'Enabled'" {
			ValueName = 'NC_PersonalFirewallConfig'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Network Connections'
			ValueData = 0

		}

		Registry "CCE-38188-9: Ensure 'Require domain users to elevate when setting a network's location' is set to 'Enabled'" {
			ValueName = 'NC_StdDomainUserSetLocation'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Network Connections'
			ValueData = 1

		}

		Registry "CCE-37567-5: Ensure 'Require secure RPC communication' is set to 'Enabled'" {
			ValueName = 'fEncryptRPCTraffic'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 1

		}

		Registry "CCE-37145-0: Ensure 'Security: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'" {
			ValueName = 'Retention'
			ValueType = 'String'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\Security'
			ValueData = '0'

		}

		Registry "CCE-37695-4: Ensure 'Security: Specify the maximum log file size ' is set to 'Enabled: 196,608 or greater'" {
			ValueName = 'MaxSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\Security'
			ValueData = 196608

		}

		Registry "CCE-36627-8: Ensure 'Set client connection encryption level' is set to 'Enabled: High Level'" {
			ValueName = 'MinEncryptionLevel'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 3

		}

		Registry "CCE-38217-6: Ensure 'Set the default behavior for AutoRun' is set to 'Enabled: Do not execute any autorun commands'" {
			ValueName = 'NoAutorun'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
			ValueData = 1

		}

		Registry "CCE-38276-2: Ensure 'Setup: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'" {
			ValueName = 'Retention'
			ValueType = 'String'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\Setup'
			ValueData = '0'

		}

		Registry "CCE-37526-1: Ensure 'Setup: Specify the maximum log file size ' is set to 'Enabled: 32,768 or greater'" {
			ValueName = 'MaxSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\Setup'
			ValueData = 32768

		}

		Registry "CCE-36788-8: Ensure 'Shutdown: Allow system to be shut down without having to log on' is set to 'Disabled'" {
			ValueName = 'ShutdownWithoutLogon'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 0

		}

		Registry "CCE-36977-7: Ensure 'Sign-in last interactive user automatically after a system-initiated restart' is set to 'Disabled'" {
			ValueName = 'DisableAutomaticRestartSignOn'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-37885-1: Ensure 'System objects: Require case insensitivity for non-Windows subsystems' is set to 'Enabled'" {
			ValueName = 'ObCaseInsensitive'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Session Manager\Kernel'
			ValueData = 1

		}

		Registry "CCE-37644-2: Ensure 'System objects: Strengthen default permissions of internal system objects ' is set to 'Enabled'" {
			ValueName = 'ProtectionMode'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Session Manager'
			ValueData = 1

		}

		Registry "CCE-35921-6: Ensure 'System settings: Optional subsystems' is set to 'Defined: '" {
			ValueName = 'Optional'
			ValueType = 'MultiString'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Session Manager\SubSYSTEMs'
			ValueData = '0'

		}

		Registry "CCE-36160-0: Ensure 'System: Control Event Log behavior when the log file reaches its maximum size' is set to 'Disabled'" {
			ValueName = 'Retention'
			ValueType = 'String'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\System'
			ValueData = '0'

		}

		Registry "CCE-36092-5: Ensure 'System: Specify the maximum log file size ' is set to 'Enabled: 32,768 or greater'" {
			ValueName = 'MaxSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\EventLog\System'
			ValueData = 32768

		}

		Registry "CCE-35893-7: Ensure 'Turn off app notifications on the lock screen' is set to 'Enabled'" {
			ValueName = 'DisableLockScreenAppNotifications'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 1

		}

		Registry "CCE-36875-3: Ensure 'Turn off Autoplay' is set to 'Enabled: All drives'" {
			ValueName = 'NoDriveTypeAutoRun'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
			ValueData = 255

		}

		Registry "CCE-37712-7: Ensure 'Turn off background refresh of Group Policy' is set to 'Disabled'" {
			ValueName = 'DisableBkGndGroupPolicy'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 0

		}

		Registry "CCE-37809-1: Ensure 'Turn off Data Execution Prevention for Explorer' is set to 'Disabled'" {
			ValueName = 'NoDataExecutionPrevention'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Explorer'
			ValueData = 0

		}

		Registry "CCE-36660-9: Ensure 'Turn off heap termination on corruption' is set to 'Disabled'" {
			ValueName = 'NoHeapTerminationOnCorruption'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Explorer'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Ensure 'Turn off Microsoft consumer experiences' is set to 'Enabled'" {
			ValueName = 'DisableWindowsConsumerFeatures'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\CloudContent'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Ensure 'Turn off multicast name resolution' is set to 'Enabled'" {
			ValueName = 'EnableMulticast'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\DNSClient'
			ValueData = 1

		}

		Registry "CCE-36809-2: Ensure 'Turn off shell protocol protected mode' is set to 'Disabled'" {
			ValueName = 'PreXPSP2ShellProtocolBehavior'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer'
			ValueData = 0

		}

		Registry "CCE-37528-7: Ensure 'Turn on convenience PIN sign-in' is set to 'Disabled'" {
			ValueName = 'AllowDomainPINLogon'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\System'
			ValueData = 0

		}

		Registry "CCE-36494-3: Ensure 'User Account Control: Admin Approval Mode for the Built-in Administrator account' is set to 'Enabled'" {
			ValueName = 'FilterAdministratorToken'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-36863-9: Ensure 'User Account Control: Allow UIAccess applications to prompt for elevation without using the secure desktop' is set to 'Disabled'" {
			ValueName = 'EnableUIADesktopToggle'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 0

		}

		Registry "CCE-37029-6: Ensure 'User Account Control: Behavior of the elevation prompt for administrators in Admin Approval Mode' is set to 'Prompt for consent on the secure desktop'" {
			ValueName = 'ConsentPromptBehaviorAdmin'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 5

		}

		Registry "CCE-36864-7: Ensure 'User Account Control: Behavior of the elevation prompt for standard users' is set to 'Automatically deny elevation requests'" {
			ValueName = 'ConsentPromptBehaviorUser'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 0

		}

		Registry "CCE-36533-8: Ensure 'User Account Control: Detect application installations and prompt for elevation' is set to 'Enabled'" {
			ValueName = 'EnableInstallerDetection'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-37057-7: Ensure 'User Account Control: Only elevate UIAccess applications that are installed in secure locations' is set to 'Enabled'" {
			ValueName = 'EnableSecureUIAPaths'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-36869-6: Ensure 'User Account Control: Run all administrators in Admin Approval Mode' is set to 'Enabled'" {
			ValueName = 'EnableLUA'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-36866-2: Ensure 'User Account Control: Switch to the secure desktop when prompting for elevation' is set to 'Enabled'" {
			ValueName = 'PromptOnSecureDesktop'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-37064-3: Ensure 'User Account Control: Virtualize file and registry write failures to per-user locations' is set to 'Enabled'" {
			ValueName = 'EnableVirtualization'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 1

		}

		Registry "CCE-36062-8: Ensure 'Windows Firewall: Domain: Firewall state' is set to 'On '" {
			ValueName = 'EnableFirewall'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 1

		}

		Registry "CCE-38117-8: Ensure 'Windows Firewall: Domain: Inbound connections' is set to 'Block '" {
			ValueName = 'DefaultInboundAction'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 1

		}

		Registry "CCE-37523-8: Ensure 'Windows Firewall: Domain: Logging: Log dropped packets' is set to 'Yes'" {
			ValueName = 'LogDroppedPackets'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
			ValueData = 1

		}

		Registry "CCE-36393-7: Ensure 'Windows Firewall: Domain: Logging: Log successful connections' is set to 'Yes'" {
			ValueName = 'LogSuccessfulConnections'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
			ValueData = 1

		}

		Registry "CCE-36088-3: Ensure 'Windows Firewall: Domain: Logging: Size limit ' is set to '16,384 KB or greater'" {
			ValueName = 'LogFileSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile\Logging'
			ValueData = 16384

		}

		Registry "CCE-36146-9: Ensure 'Windows Firewall: Domain: Outbound connections' is set to 'Allow '" {
			ValueName = 'DefaultOutboundAction'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 0

		}

		Registry "CCE-38040-2: Ensure 'Windows Firewall: Domain: Settings: Apply local connection security rules' is set to 'Yes '" {
			ValueName = 'AllowLocalIPsecPolicyMerge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 1

		}

		Registry "CCE-37860-4: Ensure 'Windows Firewall: Domain: Settings: Apply local firewall rules' is set to 'Yes '" {
			ValueName = 'AllowLocalPolicyMerge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 1

		}

		Registry "CCE-38041-0: Ensure 'Windows Firewall: Domain: Settings: Display a notification' is set to 'No'" {
			ValueName = 'DisableNotifications'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 1

		}

		Registry "CCE-38239-0: Ensure 'Windows Firewall: Private: Firewall state' is set to 'On '" {
			ValueName = 'EnableFirewall'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 1

		}

		Registry "CCE-38042-8: Ensure 'Windows Firewall: Private: Inbound connections' is set to 'Block '" {
			ValueName = 'DefaultInboundAction'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 1

		}

		Registry "CCE-35972-9: Ensure 'Windows Firewall: Private: Logging: Log dropped packets' is set to 'Yes'" {
			ValueName = 'LogDroppedPackets'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
			ValueData = 1

		}

		Registry "CCE-37387-8: Ensure 'Windows Firewall: Private: Logging: Log successful connections' is set to 'Yes'" {
			ValueName = 'LogSuccessfulConnections'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
			ValueData = 1

		}

		Registry "CCE-38178-0: Ensure 'Windows Firewall: Private: Logging: Size limit ' is set to '16,384 KB or greater'" {
			ValueName = 'LogFileSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile\Logging'
			ValueData = 16384

		}

		Registry "CCE-38332-3: Ensure 'Windows Firewall: Private: Outbound connections' is set to 'Allow '" {
			ValueName = 'DefaultOutboundAction'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 0

		}

		Registry "CCE-36063-6: Ensure 'Windows Firewall: Private: Settings: Apply local connection security rules' is set to 'Yes '" {
			ValueName = 'AllowLocalIPsecPolicyMerge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 1

		}

		Registry "CCE-37438-9: Ensure 'Windows Firewall: Private: Settings: Apply local firewall rules' is set to 'Yes '" {
			ValueName = 'AllowLocalPolicyMerge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 1

		}

		Registry "CCE-37621-0: Ensure 'Windows Firewall: Private: Settings: Display a notification' is set to 'No'" {
			ValueName = 'DisableNotifications'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 1

		}

		Registry "CCE-37862-0: Ensure 'Windows Firewall: Public: Firewall state' is set to 'On '" {
			ValueName = 'EnableFirewall'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 1

		}

		Registry "CCE-36057-8: Ensure 'Windows Firewall: Public: Inbound connections' is set to 'Block '" {
			ValueName = 'DefaultInboundAction'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 1

		}

		Registry "CCE-37265-6: Ensure 'Windows Firewall: Public: Logging: Log dropped packets' is set to 'Yes'" {
			ValueName = 'LogDroppedPackets'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
			ValueData = 1

		}

		Registry "CCE-36394-5: Ensure 'Windows Firewall: Public: Logging: Log successful connections' is set to 'Yes'" {
			ValueName = 'LogSuccessfulConnections'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
			ValueData = 1

		}

		Registry "CCE-36395-2: Ensure 'Windows Firewall: Public: Logging: Size limit ' is set to '16,384 KB or greater'" {
			ValueName = 'LogFileSize'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile\Logging'
			ValueData = 16384

		}

		Registry "CCE-37434-8: Ensure 'Windows Firewall: Public: Outbound connections' is set to 'Allow '" {
			ValueName = 'DefaultOutboundAction'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 0

		}

		Registry "CCE-36268-1: Ensure 'Windows Firewall: Public: Settings: Apply local connection security rules' is set to 'No'" {
			ValueName = 'AllowLocalIPsecPolicyMerge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 1

		}

		Registry "CCE-37861-2: Ensure 'Windows Firewall: Public: Settings: Apply local firewall rules' is set to 'No'" {
			ValueName = 'AllowLocalPolicyMerge'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 1

		}

		Registry "CCE-38043-6: Ensure 'Windows Firewall: Public: Settings: Display a notification' is set to 'Yes'" {
			ValueName = 'DisableNotifications'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 1

		}

		Registry "CCE-37843-0: Ensure 'Enable Windows NTP Client' is set to 'Enabled'" {
			ValueName = 'Enabled'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\W32Time\TimeProviders\NtpClient'
			ValueData = 1

		}

		Registry "CCE-36625-2: Ensure 'Turn off downloading of print drivers over HTTP' is set to 'Enabled'" {
			ValueName = 'DisableWebPnPDownload'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Printers'
			ValueData = 1

		}

		Registry "CCE-37163-3: Ensure 'Turn off Internet Connection Wizard if URL connection is referring to Microsoft.com' is set to 'Enabled'" {
			ValueName = 'ExitOnMSICW'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Internet Connection Wizard'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Devices: Allow undock without having to log on" {
			ValueName = 'UndockWithoutLogon'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Disable 'Configure local setting override for reporting to Microsoft MAPS'" {
			ValueName = 'LocalSettingOverrideSpynetReporting'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows Defender\SpyNet'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Disable SMB v1 client" {
			ValueName = 'DependsOnService'
			ValueType = 'MultiString'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanmanWorkstation'
			ValueData = 'Bowser","MRxSmb20","NSI'

		}

		Registry "NOT_ASSIGNED: Disable SMB v1 server" {
			ValueName = 'SMB1'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\LanmanServer\Parameters'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Disable Windows Search Service" {
			ValueName = 'Start'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Services\Wsearch'
			ValueData = 4

		}

		Registry "NOT_ASSIGNED: Enable 'Scan removable drives' by setting DisableRemovableDriveScanning  to 0" {
			ValueName = 'DisableRemovableDriveScanning'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows Defender\Scan'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Enable 'Send file samples when further analysis is required' for 'Send Safe Samples'" {
			ValueName = 'SubmitSamplesConsent'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows Defender\SpyNet'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Enable 'Turn on behavior monitoring'" {
			ValueName = 'DisableBehaviorMonitoring'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows Defender\Real-Time Protection'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Enable Windows Error Reporting" {
			ValueName = 'Disabled'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows\Windows Error Reporting'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Recovery console: Allow floppy copy and access to all drives and all folders" {
			ValueName = 'setcommand'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Setup\RecoveryConsole'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Require user authentication for remote connections by using Network Level Authentication" {
			ValueName = 'UserAuthentication'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows NT\Terminal Services'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Shutdown: Clear virtual memory pagefile" {
			ValueName = 'ClearPageFileAtShutdown'
			ValueType = 'DWORD'
			Key       = 'HKLM:\System\CurrentControlSet\Control\Session Manager\Memory Management'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Specify the interval to check for definition updates" {
			ValueName = 'SignatureUpdateInterval'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Microsoft Antimalware\Signature Updates'
			ValueData = 8

		}

		Registry "NOT_ASSIGNED: System settings: Use Certificate Rules on Windows Executables for Software Restriction Policies" {
			ValueName = 'AuthenticodeEnabled'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\Windows\Safer\CodeIdentifiers'
			ValueData = 1

		}

		Registry "NOT_ASSIGNED: Windows Firewall: Domain: Allow unicast response" {
			ValueName = 'DisableUnicastResponsesToMulticastBroadcast'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\DomainProfile'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Windows Firewall: Private: Allow unicast response" {
			ValueName = 'DisableUnicastResponsesToMulticastBroadcast'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PrivateProfile'
			ValueData = 0

		}

		Registry "NOT_ASSIGNED: Windows Firewall: Public: Allow unicast response" {
			ValueName = 'DisableUnicastResponsesToMulticastBroadcast'
			ValueType = 'DWORD'
			Key       = 'HKLM:\Software\Policies\Microsoft\WindowsFirewall\PublicProfile'
			ValueData = 1

		}

		AuditPolicySubcategory "CCE-38329-9: Ensure 'Audit Application Group Management' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Application Group Management'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "CCE-38329-9: Ensure 'Audit Application Group Management' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Application Group Management'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "CCE-38004-8: Ensure 'Audit Computer Account Management' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Computer Account Management'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "CCE-38004-8: Ensure 'Audit Computer Account Management' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Computer Account Management'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		AuditPolicySubCategory "CCE-37741-6: Ensure 'Audit Credential Validation' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Credential Validation'
			Ensure    = 'Present'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-37741-6: Ensure 'Audit Credential Validation' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Credential Validation'
			Ensure    = 'Present'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "CCE-36265-7: Ensure 'Audit Distribution Group Management' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Distribution Group Management'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "CCE-36265-7: Ensure 'Audit Distribution Group Management' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Distribution Group Management'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "CCE-38237-4: Ensure 'Audit Logoff' is set to 'Success'"
		{
			Name      = 'Logoff'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-38036-0: Ensure 'Audit Logon' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Logon'
			Ensure    = 'Present'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-38036-0: Ensure 'Audit Logon' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Logon'
			Ensure    = 'Present'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "CCE-37855-4: Ensure 'Audit Other Account Management Events' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Other Account Management Events'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "CCE-37855-4: Ensure 'Audit Other Account Management Events' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Other Account Management Events'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Ensure 'Audit PNP Activity' is set to 'Success'"
		{
			Name      = 'Plug and Play Events'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "CCE-36059-4: Ensure 'Audit Process Creation' is set to 'Success'"
		{
			Name      = 'Process Creation'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-37617-8: Ensure 'Audit Removable Storage' is set to 'Success and Failure' (Success)"
		{
			Name      = 'Removable Storage'
			Ensure    = 'Present'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-37617-8: Ensure 'Audit Removable Storage' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'Removable Storage'
			Ensure    = 'Present'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "CCE-38034-5: Ensure 'Audit Security Group Management' is set to 'Success and Failure'"
		{
			Name      = 'Security Group Management'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "CCE-36266-5: Ensure 'Audit Special Logon' is set to 'Success'"
		{
			Name      = 'Special Logon'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-37856-2: Ensure 'Audit User Account Management' is set to 'Success and Failure' (Success)"
		{
			Name      = 'User Account Management'
			Ensure    = 'Present'
			AuditFlag = 'Success'

		}

		AuditPolicySubCategory "CCE-37856-2: Ensure 'Audit User Account Management' is set to 'Success and Failure' (Failure)"
		{
			Name      = 'User Account Management'
			Ensure    = 'Present'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Audit Kerberos Authentication Service (Success)"
		{
			Name      = 'Kerberos Authentication Service'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Audit Kerberos Authentication Service (Failure)"
		{
			Name      = 'Kerberos Authentication Service'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Audit Kerberos Service Ticket Operations (Success)"
		{
			Name      = 'Kerberos Service Ticket Operations'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Audit Kerberos Service Ticket Operations (Failure)"
		{
			Name      = 'Kerberos Service Ticket Operations'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Audit Non Sensitive Privilege Use (Success)"
		{
			Name      = 'Non Sensitive Privilege Use'
			Ensure    = 'Absent'
			AuditFlag = 'Success'

		}

		AuditPolicySubcategory "NOT_ASSIGNED: Audit Non Sensitive Privilege Use (Failure)"
		{
			Name      = 'Non Sensitive Privilege Use'
			Ensure    = 'Absent'
			AuditFlag = 'Failure'

		}

		UserRightsAssignment "CCE-35818-4: Configure 'Access this computer from the network'"
		{
			Policy   = 'Access_this_computer_from_the_network'
			Identity = @('BUILTIN\Administrators', 'NT AUTHORITY\AUTHENTICATED USERS'
			)

		}

		UserRightsAssignment "CCE-37072-6: Configure 'Allow log on through Remote Desktop Services'"
		{
			Policy   = 'Allow_log_on_through_Remote_Desktop_Services'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-35823-4: Configure 'Create symbolic links'"
		{
			Policy   = 'Create_symbolic_links'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-37954-5: Configure 'Deny access to this computer from the network'"
		{
			Policy   = 'Deny_access_to_this_computer_from_the_network'
			Identity = @('BUILTIN\Guests'
			)

		}

		UserRightsAssignment "CCE-36860-5: Configure 'Enable computer and user accounts to be trusted for delegation'"
		{
			Policy   = 'Enable_computer_and_user_accounts_to_be_trusted_for_delegation'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-35906-7: Configure 'Manage auditing and security log'"
		{
			Policy   = 'Manage_auditing_and_security_log'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-37056-9: Ensure 'Access Credential Manager as a trusted caller' is set to 'No One'"
		{
			Policy   = 'Access_Credential_Manager_as_a_trusted_caller'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-36876-1: Ensure 'Act as part of the operating system' is set to 'No One'"
		{
			Policy   = 'Act_as_part_of_the_operating_system'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-35912-5: Ensure 'Back up files and directories' is set to 'Administrators'"
		{
			Policy   = 'Back_up_files_and_directories'
			Identity = @('BUILTIN\Backup Operators'
			)

		}

		UserRightsAssignment "CCE-37452-0: Ensure 'Change the system time' is set to 'Administrators, LOCAL SERVICE'"
		{
			Policy   = 'Change_the_system_time'
			Identity = @('BUILTIN\Administrators', 'NT AUTHORITY\LOCAL SERVICE'
			)

		}

		UserRightsAssignment "CCE-37700-2: Ensure 'Change the time zone' is set to 'Administrators, LOCAL SERVICE'"
		{
			Policy   = 'Change_the_time_zone'
			Identity = @('BUILTIN\Administrators', 'NT AUTHORITY\LOCAL SERVICE'
			)

		}

		UserRightsAssignment "CCE-35821-8: Ensure 'Create a pagefile' is set to 'Administrators'"
		{
			Policy   = 'Create_a_pagefile'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-36861-3: Ensure 'Create a token object' is set to 'No One'"
		{
			Policy   = 'Create_a_token_object'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-37453-8: Ensure 'Create global objects' is set to 'Administrators, LOCAL SERVICE, NETWORK SERVICE, SERVICE'"
		{
			Policy   = 'Create_global_objects'
			Identity = @('BUILTIN\Administrators', 'NT AUTHORITY\SERVICE', 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE'
			)

		}

		UserRightsAssignment "CCE-36532-0: Ensure 'Create permanent shared objects' is set to 'No One'"
		{
			Policy   = 'Create_permanent_shared_objects'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-36923-1: Ensure 'Deny log on as a batch job' to include 'Guests'"
		{
			Policy   = 'Deny_log_on_as_a_batch_job'
			Identity = @('BUILTIN\Guests'
			)

		}

		UserRightsAssignment "CCE-36877-9: Ensure 'Deny log on as a service' to include 'Guests'"
		{
			Policy   = 'Deny_log_on_as_a_service'
			Identity = @('BUILTIN\Guests'
			)

		}

		UserRightsAssignment "CCE-37146-8: Ensure 'Deny log on locally' to include 'Guests'"
		{
			Policy   = 'Deny_log_on_locally'
			Identity = @('BUILTIN\Guests'
			)

		}

		UserRightsAssignment "CCE-36867-0: Ensure 'Deny log on through Remote Desktop Services' to include 'Guests, Local account'"
		{
			Policy   = 'Deny_log_on_through_Remote_Desktop_Services'
			Identity = @('BUILTIN\Guests'
			)

		}

		UserRightsAssignment "CCE-37877-8: Ensure 'Force shutdown from a remote system' is set to 'Administrators'"
		{
			Policy   = 'Force_shutdown_from_a_remote_system'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-37639-2: Ensure 'Generate security audits' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
		{
			Policy   = 'Generate_security_audits'
			Identity = @('NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE'
			)

		}

		UserRightsAssignment "CCE-38326-5: Ensure 'Increase scheduling priority' is set to 'Administrators'"
		{
			Policy   = 'Increase_scheduling_priority'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-36318-4: Ensure 'Load and unload device drivers' is set to 'Administrators'"
		{
			Policy   = 'Load_and_unload_device_drivers'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-36495-0: Ensure 'Lock pages in memory' is set to 'No One'"
		{
			Policy   = 'Lock_pages_in_memory'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-36054-5: Ensure 'Modify an object label' is set to 'No One'"
		{
			Policy   = 'Modify_an_object_label'
			Force    = $True
			Identity = @(
			)

		}

		UserRightsAssignment "CCE-38113-7: Ensure 'Modify firmware environment values' is set to 'Administrators'"
		{
			Policy   = 'Modify_firmware_environment_values'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-36143-6: Ensure 'Perform volume maintenance tasks' is set to 'Administrators'"
		{
			Policy   = 'Perform_volume_maintenance_tasks'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-37131-0: Ensure 'Profile single process' is set to 'Administrators'"
		{
			Policy   = 'Profile_single_process'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-36052-9: Ensure 'Profile system performance' is set to 'Administrators, NT SERVICE\WdiServiceHost'"
		{
			Policy   = 'Profile_system_performance'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-37430-6: Ensure 'Replace a process level token' is set to 'LOCAL SERVICE, NETWORK SERVICE'"
		{
			Policy   = 'Replace_a_process_level_token'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-37613-7: Ensure 'Restore files and directories' is set to 'Administrators'"
		{
			Policy   = 'Restore_files_and_directories'
			Identity = @('BUILTIN\Administrators', 'BUILTIN\Backup Operators'
			)

		}

		UserRightsAssignment "CCE-38328-1: Ensure 'Shut down the system' is set to 'Administrators'"
		{
			Policy   = 'Shut_down_the_system'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "CCE-38325-7: Ensure 'Take ownership of files or other objects' is set to 'Administrators'"
		{
			Policy   = 'Take_ownership_of_files_or_other_objects'
			Identity = @('BUILTIN\Administrators'
			)

		}

		UserRightsAssignment "NOT_ASSIGNED: Bypass traverse checking"
		{
			Policy   = 'Bypass_traverse_checking'
			Identity = @('BUILTIN\Administrators', 'NT AUTHORITY\AUTHENTICATED USERS', 'BUILTIN\Backup Operators', 'NT AUTHORITY\LOCAL SERVICE', 'NT AUTHORITY\NETWORK SERVICE'
			)

		}

		UserRightsAssignment "NOT_ASSIGNED: Increase a process working set"
		{
			Policy   = 'Increase_a_process_working_set'
			Identity = @('BUILTIN\Administrators', 'NT AUTHORITY\LOCAL SERVICE'
			)

		}

		UserRightsAssignment "NOT_ASSIGNED: Remove computer from docking station"
		{
			Policy   = 'Remove_computer_from_docking_station'
			Identity = @('BUILTIN\Administrators'
			)

		}

	}
}
SecurityBaselineConfigurationWS2016