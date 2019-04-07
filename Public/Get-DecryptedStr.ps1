function Get-DecryptedStr {
    [CmdletBinding(SupportsShouldProcess)]
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
	    Write-Warning "Failed to decrypt string."
	    Write-Warning $_.InvocationInfo.ScriptName
	    Write-Warning $_.InvocationInfo.Line
	    Write-Warning $_.Exception.Message
	}
    }
}
