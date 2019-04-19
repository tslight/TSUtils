function Get-PSScriptProcess {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$PSScript
    )

    process {
	Get-WmiObject Win32_Process | Where-Object {
	    ($_.ProcessName -eq 'powershell.exe') -And
	    ($_.CommandLine -like "*$PSScript*")
	}
    }
}
