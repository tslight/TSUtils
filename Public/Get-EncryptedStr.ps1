function Get-EncryptedStr {
    [CmdletBinding()]
    Param (
	[SupportsWildcards()]
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$File
    )

    process {
	try {
	    Get-Content $File | ConvertTo-SecureString -ErrorAction Stop
	    Write-Verbose "Successfully loaded $File."
	} catch {
	    Write-TSWarning $_ "Failed to load $File." -Verbose:$VerbosePreference
	}
    }
}
