function Convert-CsvToXls {
    [CmdletBinding()]
    Param (
	[Parameter(ValueFromPipeline,Mandatory)]
	[System.IO.FileInfo[]]$Csv,
	[Parameter(Mandatory)]
	[System.IO.FileInfo]$Xlsx
    )

    begin {
	$Excel = New-Object -com Excel.Application
	$Excel.DisplayAlerts = $False
	$Excel.Visible = $False
	$Workbook = $Excel.Workbooks.Add()
	$WSNumber = 1
    }

    process {
	$CsvPath = $Csv.Fullname
	$WSName  = $Csv.name -Replace (".csv","")
	$WSNameLength = $WSName | Measure-Object -Character | Select-Object -ExpandProperty Characters
	if ($WSNameLength -gt 30) {
	    Write-Warning "$WSName is too long for an Excel Worksheet name. Truncating."
	    $WSName = $WSName.Substring(0,29)
	}
	Write-Host "Creating $WSName worksheet in $Xlsx.xlsx..."
	if ($WSNumber -gt 1) {
	    $Workbook.Worksheets.Add() | Out-Null
	}
	$Worksheet = $Workbook.Worksheets.Item(1) #Newest created worksheet is always 1
	$Worksheet.Name = $WSName
	$TempCsv = $Excel.Workbooks.Open($CsvPath)
	$TempSheet = $TempCsv.Worksheets.Item(1)
	$TempSheet.UsedRange.Copy() | Out-Null	# Copy contents of the Csv file
	$Worksheet.Paste() # Paste contents of Csv into existing workbook
	$TempCsv.Close() # Close temp workbook
	$Range = $Worksheet.UsedRange # Select all used cells
	$ColumnCount = $Range.Columns.Count # we will use this later for selecting the first row..
	$LastColumn = [char]($ColumnCount + 64) + "1"
	$Range = $Worksheet.Range("A1",$LastColumn) # select top row and make bold
	$Range = $Range.Style = 'Heading 2'
	$Range = $Worksheet.UsedRange # Select all used cells
	$Range.EntireColumn.Autofit() | Out-Null
	$Range = $Worksheet.Range("A1") # select first cell to clear selection
	$Range.Select() | Out-Null
	$WSNumber++
    }

    end {
	try {
	    $Workbook.SaveAs("$Xlsx.xlsx")
	    Write-Host "File saved to $Xlsx.xlsx"
	} catch [System.Runtime.InteropServices.COMException] {
	    Write-Warning "CAN'T SAVE $Xlsx.xlsx."
	    Write-Warning "Someone else may have this file open..."
	}
	$Excel.Quit()
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel) | Out-Null
	if (Get-Process Excel -ErrorAction SilentlyContinue) {
	    Stop-Process -Name Excel
	}
    }
}
