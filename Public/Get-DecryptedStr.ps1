function Get-DecryptedStr {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.Security.SecureString]$EncryptedStr
    )

    process {
	try {
	    [System.Runtime.InteropServices.marshal]::PtrToStringAuto(
		[System.Runtime.InteropServices.marshal]::SecureStringToBSTR(
		    $EncryptedStr
		)
	    )
	} catch {
	    Write-TSWarning $_ "Failed to decrypt string." -Verbose:$VerbosePreference
	}
    }
}
