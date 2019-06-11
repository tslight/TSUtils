function ConvertTo-PlainText {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.Security.SecureString]$SecureString
    )

    process {
	try {
	    [System.Runtime.InteropServices.marshal]::PtrToStringAuto(
		[System.Runtime.InteropServices.marshal]::SecureStringToBSTR(
		    $SecureString
		)
	    )
	} catch {
	    Write-TSWarning $_ "Failed to decrypt string." -Verbose:$VerbosePreference
	}
    }
}
