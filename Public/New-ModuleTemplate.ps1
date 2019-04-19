function New-ModuleTemplate {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Name,
	[System.IO.FileInfo]$Path=($env:PSModulePath -split ':|;' | Select-Object -last 1)
    )

    process {
	New-Path "$Path\$Name\Public" -Type 'Directory'
	New-Path "$Path\$Name\Private" -Type 'Directory'
	New-Path "$Path\$Name\$Name.psm1" -Type 'File'
	New-Path "$Path\$Name\$Name.psd1" -Type 'File'
    }
}
