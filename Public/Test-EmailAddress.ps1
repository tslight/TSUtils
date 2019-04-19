function Test-EmailAddress {
    [cmdletbinding()]
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
