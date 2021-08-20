function Invoke-PowershellAs {
    [CmdletBinding()]
    Param (
	[string]$Username=$(Read-Host "Enter a username"),
	[switch]$RunAs
    )

    $FileName   = $Username -Replace ("\\",".")
    $CredDir    = "$env:APPDATA\Microsoft\Credentials"
    $SecureFile = "$CredDir\$Filename.pspw"

    if (Test-Path $SecureFile) {
	Write-Verbose "Getting password from $SecureFile"
	$Password = Get-Content $SecureFile | ConvertTo-SecureString
    } else {
	Write-Warning "$SecureFile not found."
	New-Path $CredDir -Type 'Directory'
	$Password = Read-Host -AsSecureString "Enter $User password"
	if (Get-Answer "Cache encrypted password for future use? (Yes or No)") {
	    Write-Host "Saving encrypted password for future use to $SecureFile"
	    $String = $Password | ConvertFrom-SecureString
	    Set-Content $SecureFile $String
	} else {
	    Write-Host "Not caching password."
	}
    }

    $Credential = New-Object System.Management.Automation.PSCredential $Username, $Password

    if ($RunAs) {
	$Arg = "Start-Process powershell.exe"
    } else {
	$Arg = "Start-Process powershell.exe -Verb RunAs"
    }

    $Args = @{
	Credential   = $Credential
	NoNewWindow  = $True
	ArgumentList = $Arg
    }

    Start-Process powershell.exe @Args
}
