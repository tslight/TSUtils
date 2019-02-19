#region get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
#endregion

#region source the files
foreach ($import in @($Public + $Private)) {
    Try {
	. $import.fullname
    } Catch {
	Write-Error -Message "Failed to import function $($import.fullname): $_"
    }
}
#endregion

#region read in or create an initial config file and variable
#endregion

#region set variables visible to the module and its functions only
#endregion

#region export Public functions ($Public.BaseName) for WIP modules
Export-ModuleMember -Function $Public.Basename
#endregion
