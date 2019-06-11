function New-WeekObject {
    [CmdletBinding(SupportsShouldProcess)]
    Param ()

    $Week = New-Object PSObject

    for ($d=1; $d -le 7; $d++) {
	$Array = @()
	$Day   = Get-DayOfWeek $d
	$Week | Add-Member -MemberType NoteProperty -Name $Day -Value $Array
    }

    return $Week
}
