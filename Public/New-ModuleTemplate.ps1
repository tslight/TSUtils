function New-ModuleTemplate {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Names,
	[System.IO.FileInfo]$Path=($env:PSModulePath -split ':|;' | Select-Object -last 1),
	[switch]$Config
    )

    begin {
	$Templates	= "$PSScriptRoot\..\Templates"
	$TemplateConfig = "$Templates\TemplateConfig.psm1"
	$Template	= "$Templates\Template.psm1"
	$Manifest	= "$Templates\Template.psd1"
	$TemplateColors = "$Templates\TemplateColors.ps1"
    }

    process {
	foreach ($Name in $Names) {
	    $Directories = @(
		'Classes'
		'Public'
		'Private'
	    )

	    foreach ($Directory in $Directories) {
		New-Path "$Path\$Name\$Directory" -Type 'Directory'
	    }

	    Copy-Item $TemplateConfig "$Path\$Name\Config.ps1"

	    if ($Config) {
		(Get-Content $Template) -Replace ('\#\.\s','. ') |
		  Set-Content "$Path\$Name\$Name.psm1"
	    } else {
		Copy-Item $Template "$Path\$Name\$Name.psm1"
	    }

	    Copy-Item $TemplateColors "$Path\$Name\Colors.ps1"

	    (Get-Content $Manifest).Replace('ModuleName',$Name) |
	      Set-Content "$Path\$Name\$Name.psd1"
	}
    }
}
