function Get-EncryptedStr {
    [CmdletBinding(SupportsShouldProcess)]
    param (
	[SupportsWildcards()]
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$File
    )

    process {
	try {
	    Get-Content $File | ConvertTo-SecureString -ErrorAction Stop
	    Write-Verbose "Successfully loaded $File."
	} catch {
	    Write-Warning "Failed to load $File."
	    Write-Warning $_
	}
    }
}
