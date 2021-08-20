function Get-CredentialFromFile {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$File,
	[Parameter(Mandatory)]
	[string]$Username
    )

    process {
	$Password = Get-SecureStringFromFile $File
	New-Object System.Management.Automation.PSCredential $Username, $Password
    }
}
