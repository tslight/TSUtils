# TSUtils Powershell Module

*Collection of miscellaneous powershell functions.*

<a id='public'></a>
## PUBLIC CMDLETS

| **CMDLET** | **SYNOPSIS** | **PARAMETER** | **DESCRIPTION** |
|:-----------|:-------------|:--------------|:----------------|
| `Add-VbaToXls` | Add-VbaToXls -Xlsx FileInfo -VbaCode string CommonParameters | `-Xlsx`|  |
 |	|	| `-VbaCode`|  |
| `Add-XlsTitleRow` | Add-XlsTitleRow -Xlsx FileInfo -Title string CommonParameters | `-Xlsx`|  |
 |	|	| `-Title`|  |
| `Convert-CsvToXls` | Convert-CsvToXls -Csv FileInfo -Xlsx FileInfo CommonParameters | `-Csv`|  |
 |	|	| `-Xlsx`|  |
| `ConvertFrom-BytesToHumanReadable` | ConvertFrom-BytesToHumanReadable -Bytes double CommonParameters | `-Bytes`|  |
| `ConvertFrom-HashTable` | ConvertFrom-HashTable -HashTable hashtable CommonParameters | `-HashTable`|  |
| `ConvertTo-HashTable` | ConvertTo-HashTable -Object Object CommonParameters | `-Object`|  |
| `ConvertTo-Letter` | ConvertTo-Letter -Number int CommonParameters | `-Number`|  |
| `Get-Alphabet` | Get-Alphabet -Upper -Lower -WhatIf -Confirm CommonParameters | `-Upper`|  |
 |	|	| `-Lower`|  |
| `Get-Answer` | Get-Answer -Question string CommonParameters | `-Question`|  |
| `Get-CsvColumn` | Get-CsvColumn -Csv FileInfo -Column string CommonParameters | `-Csv`|  |
 |	|	| `-Column`|  |
| `Get-DiskUsage` | Get-DiskUsage -Path string -Bytes CommonParameters | `-Path`|  |
 |	|	| `-Bytes`|  |
| `Get-LocalVariables` | Get-LocalVariables -Foo string -Bar string -Baz string | `-Foo`|  |
 |	|	| `-Bar`|  |
 |	|	| `-Baz`|  |
| `Get-Parameters` | Get-Parameters -Function string CommonParameters | `-Function`|  |
| `Get-PSScriptProcess` | Get-PSScriptProcess -PSScript string CommonParameters | `-PSScript`|  |
| `Import-LocalModules` | Import-LocalModules -Include array CommonParameters | `-Include`|  |
| `Invoke-PowershellAs` | Invoke-PowershellAs -Username string -RunAs CommonParameters | `-Username`|  |
 |	|	| `-RunAs`|  |
| `Merge-MultipleObjects` | Merge-MultipleObjects -Objects Object CommonParameters | `-Objects`|  |
| `Merge-TwoObjects` | Merge-TwoObjects -ObjectOne Object -ObjectTwo Object -PrefixOne string -PrefixTwo string -WhatIf -Confirm CommonParameters | `-ObjectOne`|  |
 |	|	| `-ObjectTwo`|  |
 |	|	| `-PrefixOne`|  |
 |	|	| `-PrefixTwo`|  |
| `New-ModuleTemplate` | Generate module scaffolding and boilerplate. | `-Names`| The names of the modules you want to create. |
 |	|	| `-Path`| The path to store these modules in. Defaults to the last path found in $env:PSModulePath. |
 |	|	| `-Author`| Name of the modules author. This will be inserted into the Author and Copyright fields in the manifest file. Defaults to the current users' name. |
 |	|	| `-CompanyName`| This will be inserted into the Company field of the manifest file. Defaults to nil. |
 |	|	| `-Description`| Description of the module. This will be inserted into the description field of the module manifest and at the top of the main README.md. |
 |	|	| `-RequiredModules`| List of modules that this module depends on. Will be inserted into the RequiredModules field of the manifest file. |
 |	|	| `-UncommentConfig`| A switch that uncomments a line in the psm1 file that dot sources the configuration management script. This is stored in Config.ps1 and allows reading in of sensitive data stored in a Config.psd1 for setting variables available in the modules' scope. |
| `New-Path` | New-Path -Path string -Type string -Force -WhatIf -Confirm CommonParameters | `-Path`|  |
 |	|	| `-Type`|  |
 |	|	| `-Force`|  |
| `Remove-Accents` | Remove-Accents -str string -Force -WhatIf -Confirm CommonParameters | `-str`|  |
 |	|	| `-Force`|  |
| `Set-DefaultDisplayPropertySet` | Set-DefaultDisplayPropertySet -Object Object -Properties string -TypeName string CommonParameters | `-Object`|  |
 |	|	| `-Properties`|  |
 |	|	| `-TypeName`|  |
| `Test-EmailAddress` | Test-EmailAddress -EmailAddress string CommonParameters | `-EmailAddress`|  |
| `Test-IsPSScriptRunning` | Test-IsPSScriptRunning -PSScript string CommonParameters | `-PSScript`|  |
| `Write-SleepProgress` | Write-SleepProgress -Seconds int -ProcessName string CommonParameters | `-Seconds`|  |
 |	|	| `-ProcessName`|  |
| `Write-StdOutAndLog` | Write-StdOutAndLog -msg string -log string -Overwrite CommonParameters | `-msg`|  |
 |	|	| `-log`|  |
 |	|	| `-Overwrite`|  |
| `Write-TSWarning` | Write-TSWarning -Exception Object -Warning string CommonParameters | `-Exception`|  |
 |	|	| `-Warning`|  |

<a id='private'></a>
## PRIVATE FUNCTIONS

| **CMDLET** | **SYNOPSIS** | **PARAMETER** | **DESCRIPTION** |
|:-----------|:-------------|:--------------|:----------------|
