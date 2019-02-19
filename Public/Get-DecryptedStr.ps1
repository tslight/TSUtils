function Get-DecryptedStr {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.Security.SecureString]$EncryptedStr
    )

    process {
	try {
	    [System.Runtime.InteropServices.marshal]::PtrToStringAuto([System.Runtime.InteropServices.marshal]::SecureStringToBSTR($EncryptedStr))
	} catch {
	    Write-Warning "Failed to decrypt string."
	    Write-Warning $_
	}
    }
}
