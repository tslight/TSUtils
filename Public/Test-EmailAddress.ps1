function Test-EmailAddress {
    [cmdletbinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$EmailAddress
    )

    try {
	$Null = [MailAddress]$EmailAddress
	return $True
    } catch {
	return $False
    }
}
