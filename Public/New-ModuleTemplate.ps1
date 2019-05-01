function New-ModuleTemplate {
    <#
    .SYNOPSIS
    Generate module scaffolding and boilerplate.

    .DESCRIPTION
    Creates Public, Private & Classes directories. A psm1 script that sources
    functions from Public & Private and exports those in Public, a manifest
    file, a file that defines color splatting hash tables and a script for
    supporting module configuration management.

    .PARAMETER Names
    The names of the modules you want to create.

    .PARAMETER Path
    The path to store these modules in. Defaults to the last path found in
    $env:PSMOdulePath

    .PARAMETER Author
    Name of the modules author. This will be inserted into the Author and
    Copyright fields in the manifest file. Defaults to the current users' name

    .PARAMETER UncommentConfig
    A switch that uncomments a line in the psm1 file that dot sources the
    configuration management script. This is stored in Config.ps1 and allows
    reading in of sensitive data stored in a Config.psd1 for setting variables
    available in the modules' scope.

    .EXAMPLE
    $Params = @{
	Name = Module1,Module2,Module3
	Path = "C:\MyModules"
	Author = "Me Myself & I"
	CompanyName = "My Awesome Company"
	Description = "This module will rock your world!"
	RequiredModules = 'All','My','Other','Modules'
    }
    New-ModuleTemplate @Params
    #>
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Names,
	[System.IO.FileInfo]$Path=($env:PSModulePath -split ':|;' | Select-Object -last 1),
	[string]$Author=$env:USER,
	[string]$CompanyName="",
	[string]$Description="Module Description",
	[string[]]$RequiredModules=@(),
	[switch]$UncommentConfig
    )

    begin {
	$Templates = "$PSScriptRoot\..\Templates"
	$Module    = "$Templates\Module.psm1"
	$Manifest  = "$Templates\Manifest.psd1"
	$Config	   = "$Templates\Config.ps1"
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
		Set-Content -Value "# $Name $Directory Functions" -Path "$Path\$Name\$Directory\README.md"
		Write-Verbose "Generated $Path\$Name\$Directory."
	    }

	    Set-Content -Value "# $Name Powershell Module" -Path "$Path\$Name\README.md"
	    Add-Content -Value "`n*$Description*`n" -Path "$Path\$Name\README.md"

	    Copy-Item $Config "$Path\$Name\Config.ps1"
	    Write-Verbose "Copied $Config to $Path\$Name\Config.ps1."

	    if ($UncommentConfig) {
		(Get-Content $Module) -Replace ('\#\.\s','. ') |
		  Set-Content "$Path\$Name\$Name.psm1"
	    } else {
		Copy-Item $Module "$Path\$Name\$Name.psm1"
	    }
	    Write-Verbose "Copied $Module to $Path\$Name\$Name.psm1."

	    Copy-Item $Colors "$Path\$Name\Colors.ps1"
	    Write-Verbose "Copied $Colors to $Path\$Name\Colors.ps1."

	    $Params = @{
		Path = "$Path\$Name\$Name.psd1"
		RootModule = $Name
		Author = $Author
		Copyright = "(c) $(Get-Date -Uformat %Y) $Author. All rights reserved."
		CompanyName = $CompanyName
		Description = $Description
		RequiredModules = $RequiredModules
		FunctionsToExport = '*'
		AliasesToExport = '*'
		VariablesToExport = '*'
		CmdletsToExport = '*'
	    }
	    New-ModuleManifest @Params
	    Write-Verbose "Generated $Module manifest at $Path\$Name\$Name.psd1."

	    Copy-Item $GitIgnore "$Path\$Name\.gitignore"
	    Write-Verbose "Copied $GitIgnore to $Path\$Name\.gitignore."
	}
    }
}
