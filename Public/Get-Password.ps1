function Get-Password {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Position=0)]
	[string]$Uri="http://www.dinopass.com/password/strong"
    )

    try {
	Write-Verbose "Getting password from $Uri"
	$Password = Invoke-RestMethod -Method GET -Uri $Uri
	return Test-Password $Password
    } catch {
	Write-Warning "Failed to get password from $Uri."
	Write-Verbose "$_.Exception.Message"
	Write-Verbose "Making our own..."
	$chars = @()
	for ($a=33; $a -le 126; $a++) {
	    $chars += ,[char][byte]$a
	}
	for ($i=0; $i -le 12; $i++) {
	    return ($chars | Get-Random)
	}
    }
}
