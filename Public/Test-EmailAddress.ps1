function Test-EmailAddress {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline,Position=0)]
	[string]$EmailAddress
    )

    try {
	$Null = [MailAddress]$EmailAddress
	return $True
    } catch {
	return $False
    }
}
