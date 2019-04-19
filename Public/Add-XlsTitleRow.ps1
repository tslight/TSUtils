function Add-XlsTitleRow {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[System.IO.FileInfo]$Xlsx,
	[Parameter(Mandatory)]
	[string]$Title
    )

    begin {
	$Excel = New-Object -com Excel.Application
	$Excel.DisplayAlerts = $False
	$Excel.Visible = $False
    }

    process {
	Write-Host "Adding $Title title to first row of first sheet in $Xlsx workbook..."
	$Workbook    = $Excel.Workbooks.Open($Xlsx)
	$Worksheet   = $Workbook.Worksheets(1)
	$FirstRow    = $Worksheet.Cells.Item(1,1).EntireRow
	# $xlShiftDown is a built in excel object constant for -4121 - which shifts the row down.. because magic.
	$FirstRow.Insert($xlShiftDown) | Out-Null
	$Worksheet.Cells.Item(1,1) = $Title
	$Range       = $Worksheet.UsedRange # Select all used cells
	$ColumnCount = $Range.Columns.Count # we will use this later for selecting the first row..
	$LastColumn  = [char]($ColumnCount + 64) + "1"
	$Range       = $Worksheet.Range("A1", $LastColumn) # select top row
	$Range       = $Range.Style = 'Title'
	$Workbook.SaveAs("$Xlsx")
	$Workbook.Close()
	Write-Host "File saved to $Xlsx"
    }

    end {
	$Excel.Quit()
	[System.Runtime.Interopservices.Marshal]::ReleaseComObject($Excel) | Out-Null
	if (Get-Process Excel -ErrorAction SilentlyContinue) {
	    Stop-Process -Name Excel
	}
    }
}
