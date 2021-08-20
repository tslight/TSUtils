function Get-RandomUser {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[switch]$RandomUser,
	[switch]$UINames
    )

    if ($RandomUser) {
	try {
	    (Invoke-RestMethod -Method Get -Uri "https://randomuser.me/api/").Results
	} catch {
	    Write-TSWarning $_ -Verbose:$VerbosePreference
	}
    } elseif ($UINames) {
	try {
	    Invoke-RestMethod -Method Get -Uri "https://uinames.com/api/"
	} catch {
	    Write-TSWarning $_ -Verbose:$VerbosePreference
	}
    } else {
	try {
	    $Firstname = Get-RandomWord
	    $Lastname  = Get-RandomWord
	} catch {
	    $Firstname = Get-RandomName
	    $Lastname  = Get-RandomName
	}
	[PSCustomObject]@{
	    Firstname = $Firstname
	    Lastname  = $Lastname
	    Username  = "$Firstname.$Lastname"
	}
    }
}
