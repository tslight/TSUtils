function Export-ModuleCmdletsToMarkdownTable {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo[]]$ModulePath,
	[System.IO.FileInfo]$ExportPath="$ModulePath\README.md",
	[switch]$Append
    )

    process {
	try {
	    if (-Not $Append) {
		$Contents = @()
		$File = Get-Content $ExportPath -ErrorAction SilentlyContinue
		foreach ($line in $File) {
		    if ($line -ne "<a id='public'></a>") {
			$Contents += $line
		    } else {
			break
		    }
		}
		Remove-Item -Path $ExportPath
		foreach ($line in $Contents) {
		    Add-Content -Value $line -Path $ExportPath
		}
	    }
	    Get-ModuleParamsInMarkdown $ModulePath | Add-Content -Path $ExportPath -ErrorAction Stop
	} catch [System.IO.IOException] {
	    Write-Warning "$ExportPath is being used by another process."
	} catch {
	    Write-TSWarning $_ -Verbose:$VerbosePreference
	}
    }
}
