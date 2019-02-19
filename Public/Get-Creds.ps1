function Get-Creds {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,Position=0)]
	[string]$PwdFile,
	[Parameter(Mandatory,Position=1)]
	[string]$User
    )

    $Pass = Get-EncryptedStr $PwdFile
    # Easy lookups when creating on these domains. Template, DA account, password
    $Creds  = New-Object System.Management.Automation.PSCredential $User, $Pass
    return $Creds
}
