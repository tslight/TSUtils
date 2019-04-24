function Get-RandomWord {
    [CmdletBinding()]
    Param (
	[int]$Number=1
    )

    $Url = "https://random-word-api.herokuapp.com/"
    $ApiKey = "QOE6HIW8"
    $Slug = "word?key=$ApiKey&number=$Number"
    $Uri = "$Url/$Slug"

    try {
	Invoke-RestMethod -Method Get -Uri $Uri
    } catch {
	Write-TSWarning $_ -Verbose:$VerbosePreference
	throw
    }
}
