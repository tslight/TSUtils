function Remove-Accents {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$str,
	[switch]$Force
    )

    process {
	if ($Force -or $PSCmdlet.ShouldProcess("ShouldProcess?")) {
	    # https://lazywinadmin.com/2015/05/powershell-remove-diacritics-accents.html
	    [Text.Encoding]::ASCII.GetString(
		[Text.Encoding]::GetEncoding("Cyrillic").GetBytes($str)
	    )
	}
    }
}
