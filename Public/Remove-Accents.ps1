function Remove-Accents {
    [cmdletbinding(SupportsShouldProcess)]
    param (
	[Parameter(Mandatory,ValueFromPipeline,Position=0)]
	[string]$str
    )

    # https://lazywinadmin.com/2015/05/powershell-remove-diacritics-accents.html
    return [Text.Encoding]::ASCII.GetString([Text.Encoding]::GetEncoding("Cyrillic").GetBytes($str))
}
