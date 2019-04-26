function Write-SleepProgress {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,Position=0)]
	[int]$Seconds,
	[Parameter(Mandatory,Position=1)]
	[string]$ProcessName
    )

    Write-Verbose "Waiting $Seconds seconds for $ProcessName to complete..."
    $msg = "Running $ProcessName..."

    for ($i=$Seconds; $i -gt 0; $i--) {
	$Percent = (($Seconds - $i) / $Seconds) * 100
	Write-Progress -Activity $msg -Status " " -SecondsRemaining $i -PercentComplete $Percent
	Start-Sleep 1
    }

    Write-Progress -Activity $msg -Status " " -Completed
    Write-Verbose "$ProcessName completed."
}
