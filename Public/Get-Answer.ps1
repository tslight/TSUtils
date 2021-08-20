function Get-Answer {
    [cmdletbinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$Question
    )

    while ($True) {
	$Ans = Read-Host "$Question"
	switch -Regex ($ans) {
	    '^y(es)?$'  { return $True }
	    '^n(o)?$'   { return $False }
	    '^q(uit)?$' { exit }
	    default {
		Write-Host -Fore Red "($ans) is invalid. Enter (y)es, (n)o or (q)uit."
	    }
	}
    }
}
