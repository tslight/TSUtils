function New-ModuleTemplate {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Names,
	[System.IO.FileInfo]$Path=($env:PSModulePath -split ':|;' | Select-Object -last 1),
	[switch]$Config
    )

    begin {
	$Templates = "$PSScriptRoot\..\Templates"
	$Config	   = "$Templates\Config.psm1"
	$Module    = "$Templates\Module.psm1"
	$Manifest  = "$Templates\Manifest.psd1"
	$Colors	   = "$Templates\Colors.ps1"
	$GitIgnore = "$Templates\GitIgnore"
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
		Write-Verbose "Generated $Path\$Name\$Directory."
	    }

	    Copy-Item $Config "$Path\$Name\Config.ps1"
	    Write-Verbose "Copied $Config to $Path\$Name\Config.ps1."

	    if ($Config) {
		(Get-Content $Template) -Replace ('\#\.\s','. ') |
		  Set-Content "$Path\$Name\$Name.psm1"
	    } else {
		Copy-Item $Template "$Path\$Name\$Name.psm1"
	    }
	    Write-Verbose "Copied $Module to $Path\$Name\$Name.psm1."

	    Copy-Item $TemplateColors "$Path\$Name\Colors.ps1"
	    Write-Verbose "Copied $Colors to $Path\$Name\Colors.ps1."

	    (Get-Content $Manifest).Replace('ModuleName',$Name) |
	      Set-Content "$Path\$Name\$Name.psd1"
	    Write-Verbose "Copied $Manifest to $Path\$Name\$Name.psd1."

	    Copy-Item $GitIgnore "$Path\$Name\.gitignore"
	    Write-Verbose "Copied $GitIgnore to $Path\$Name\.gitignore."
	}
    }
}
