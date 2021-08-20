function Get-RandomName {
    [CmdletBinding()]
    Param (
	[int]$Min=3,
	[int]$Max=6
    )

    $Uri = "https://uzby.com/api.php?min=$Min&max=$Max"

    try {
	Invoke-RestMethod -Method Get -Uri $Uri
    } catch {
	Write-TSWarning $_ -Verbose:$VerbosePreference
	throw
    }
}
