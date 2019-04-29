#region get public and private function definition files.
$Public  = @(
    Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue
)
$Private = @(
    Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue
)
#endregion

#region source the files
foreach ($Function in @($Public + $Private)) {
    $FunctionPath = $Function.fullname
    try {
	. $FunctionPath # dot source function
    } catch {
	Write-Error -Message "Failed to import function at $($FunctionPath): $_"
    }
}
#endregion

#region read in or create an initial config file and variable
$ConfigFile = "Config.psd1"

if (Test-Path "$PSScriptRoot\$ConfigFile") {
    try {
	$Params     = @{
	    BaseDirectory = $PSScriptRoot
	    FileName      = $ConfigFile
	}
	$Config = Import-LocalizedData @Params
	$Config = Import-LocalizedData @Params
	foreach ($variable in $Config.keys) {
	    Write-Verbose "Setting $var variable."
	    New-Variable -Name "$variable" -Value $Config.$variable -Force
	}
    } catch {
	Write-Warning "Invalid configuration data in $ConfigFile."
	Write-Warning "Please fill out or correct $PSScriptRoot\$ConfigFile."
	Write-Verbose $_.Exception.Message
	Write-Verbose $_.InvocationInfo.ScriptName
	Write-Verbose $_.InvocationInfo.PositionMessage
    }
} else {
    @"
@{
    Variable = ""
}
"@ | Out-File -Encoding UTF8 -FilePath "$PSScriptRoot\$ConfigFile"
    Write-Warning "Generated $PSScriptRoot\$ConfigFile."
    Write-Warning "Please edit $ConfigFile and re-import module."
}
#endregion

#region set variables visible to the module and its functions only
$Date = Get-Date -UFormat "%Y.%m.%d"
$Time = Get-Date -UFormat "%H:%M:%S"
$Green = @{
    Background = 'Black'
    Foreground = 'Green'
}
$Cyan = @{
    Background = 'Black'
    Foreground = 'Cyan'
}
$Magenta = @{
    Background = 'Black'
    Foreground = 'Magenta'
}
#endregion

#region export Public functions ($Public.BaseName) for WIP modules
Export-ModuleMember -Function $Public.Basename
#endregion
