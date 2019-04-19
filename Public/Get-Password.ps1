function Get-Password {
    [CmdletBinding()]
    Param (
	[string]$Uri="http://www.dinopass.com/password/strong",
	[switch]$Encrypt
    )

    try {
	Write-Verbose "Getting password from $Uri"
	$Password = Invoke-RestMethod -Method GET -Uri $Uri
    } catch {
	Write-TSWarning $_ "Failed to get password from $Uri." -Verbose:$VerbosePreference
	Write-Verbose "Making our own..."
	$Password = New-Password
    }

    if ($Encrypt) {
	Test-Password $Password | ConvertTo-SecureString -AsPlainText -Force
    } else {
	Test-Password $Password
    }
}
