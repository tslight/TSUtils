function New-ModuleTemplate {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Name,
	[System.IO.FileInfo]$Path=($env:PSModulePath -split ':|;' | Select-Object -last 1),
	[switch]$Config
    )

    begin {
	$ModuleTemplateDir = "$PSScriptRoot\..\Templates"
	$ModuleTemplateWithConfig = "$ModuleTemplateDir\Template-Config.psm1"
	$ModuleTemplate = "$ModuleTemplateDir\Template.psm1"
	$ModuleManifest = "$ModuleTemplateDir\Template.psd1"
    }

    process {
	$ModuleDirectories = @(
	    'Classes'
	    'Public'
	    'Private'
	)

	foreach ($Directory in $ModuleDirectories) {
	    New-Path "$Path\$Name\$Directory" -Type 'Directory'
	}

	if ($Config) {
	    Get-Content $ModuleTemplateWithConfig | Set-Content "$Path\$Name\$Name.psm1"
	} else {
	    Get-Content $ModuleTemplate | Set-Content "$Path\$Name\$Name.psm1"
	}
	Get-Content $ModuleManifest | Set-Content "$Path\$Name\$Name.psd1"
    }
}
