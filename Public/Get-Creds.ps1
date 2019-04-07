function Get-Creds {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,Position=0)]
	[string]$PwdFile,
	[Parameter(Mandatory,Position=1)]
	[string]$User
    )

    $Pass = Get-EncryptedStr $PwdFile
    New-Object System.Management.Automation.PSCredential $User, $Pass
}
