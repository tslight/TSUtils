function Get-RandomWord {
    [CmdletBinding()]
    Param (
	[int]$Number=1
    )

    $Url = "https://random-word-api.herokuapp.com/"

    try {
	$ApiKey = Invoke-RestMethod -Method Get -Uri "$Url/key"
    } catch {
	$Params = @{
	    Exception = $_
	    Warning = "Failed to get a valid API key."
	    Verbose = $VerbosePreference
	}
	Write-TSWarning @Params
	throw
    }

    $Slug = "word?key=$ApiKey&number=$Number"
    $Uri = "$Url/$Slug"

    try {
	$Word = Invoke-RestMethod -Method Get -Uri $Uri
    } catch {
	Write-TSWarning $_ -Verbose:$VerbosePreference
	throw
    }

    if ($Word -eq "wrong api key") {
	throw "Invalid API key."
    } else {
	Write-Output $Word
    }
}
