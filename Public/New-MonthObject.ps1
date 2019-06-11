function New-MonthObject {
    [CmdletBinding(SupportsShouldProcess)]
    Param ()

    $Month = New-Object PSObject

    for ($i=1; $i -le 5; $i++) {
	$Week = New-WeekObject
	$Month | Add-Member -MemberType NoteProperty -Name "Week $i" -Value $Week
    }

    return $Month
}
