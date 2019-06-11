function Export-Year {
    [CmdletBinding(SupportsShouldProcess)]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string[]]$Year,
	[Parameter(Mandatory)]
	[System.IO.FileInfo]$Path
    )

    process {
	$YearPath = "$Path\$Year"
	New-Path "$YearPath" -Type 'Directory'
	for ($m = 1; $m -le 12; $m++) {
	    $Month = Get-Date -Month $m -UFormat '%b'
	    $MonthPath = "$YearPath\Csv\$Month"
	    for ($w = 1; $w -le 5; $w++) {
		$Week = "Week $w"
		$WeekTickets = @()
		for ($d = 1; $d -le 7; $d++) {
		    $Day = Get-DayOfWeek $d
		    if ($Years.$Year.$Month.$Week.$Day.count -gt 0) {
			$WeekTickets += $Years.$Year.$Month.$Week.$Day
		    }
		}
		if ($WeekTickets) {
		    New-Path "$MonthPath" -Type 'Directory'
		    $WeekPath = "$MonthPath\$Week.csv"
		    Write-Host -Back Black -Fore Cyan "Creating $WeekPath"
		    $WeekTickets | Export-Csv "$WeekPath" -NoTypeInformation
		}
	    }
	    if (Get-ChildItem "$MonthPath\*.csv") {
		Write-Host -Back Black -Fore Magenta "Creating $YearPath\$Month.xlsx from Csvs at $MonthPath..."
		Get-ChildItem "$MonthPath\*.csv" | Convert-CsvToXls -Xlsx "$YearPath\$Month"
	    }
	}
    }
}
