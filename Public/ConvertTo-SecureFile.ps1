function ConvertTo-SecureFile {
    [CmdletBinding(,DefaultParameterSetName='Path')]
    Param (
	[Parameter(
	     Mandatory,
	     ParameterSetName='Path',
	     Position=0,
	     ValueFromPipeline,
	     ValueFromPipelineByPropertyName
	 )]
	[ValidateNotNullOrEmpty()]
	[SupportsWildcards()]
	[string[]]$Path,
	[Parameter(
	     Mandatory,
	     ParameterSetName='LiteralPath',
	     Position=0,
	     ValueFromPipelineByPropertyName
	 )]
	[ValidateNotNullOrEmpty()]
	[Alias('PSPath')]
	[string[]]$LiteralPath,
	[switch]$ReplaceFile
    )

    # https://4sysops.com/archives/process-file-paths-from-the-pipeline-in-powershell-functions/
    process {
	if ($PSCmdlet.ParameterSetName -eq 'Path') {
	    $ResolvedPaths = Resolve-Path -Path $Path | Select-Object -ExpandProperty Path
	} elseif ($PSCmdlet.ParameterSetName -eq 'LiteralPath') {
	    $ResolvedPaths = Resolve-Path -LiteralPath $LiteralPath | Select-Object -ExpandProperty Path
	}

	foreach ($Item in $ResolvedPaths) {
	    $File = Get-Item -LiteralPath $Item
	    $EncryptedStr = Get-Content $File |
	      ConvertTo-SecureString -AsPlainText -force |
	      ConvertFrom-SecureString
	    if ($ReplaceFile) {
		Write-Verbose "Re-writing $File with encrypted string: $EncryptedStr"
		Set-Content $File $EncryptedStr
	    } else {
		Write-Output $EncryptedStr
	    }
	}
    }
}
