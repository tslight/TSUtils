function Set-DefaultDisplayPropertySet {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[object[]]$Object,
	[Parameter(Mandatory)]
	[string[]]$Properties,
	[string]$TypeName
    )
    # https://learn-powershell.net/2013/08/03/quick-hits-set-the-default-property-display-in-powershell-on-custom-objects/
    process {
	foreach ($o in $Object) {
	    if ($TypeName) {
		$o.PSObject.TypeNames.Insert(0,$TypeName)
	    }
	    # Create the default property display set
	    $DefaultDisplayPropertySet = New-Object System.Management.Automation.PSPropertySet(
		'DefaultDisplayPropertySet',[string[]]$Properties
	    )
	    $PSStandardMembers = [System.Management.Automation.PSMemberInfo[]]@($DefaultDisplayPropertySet)
	    $Params = @{
		MemberType	= 'MemberSet'
		Name		= 'PSStandardMembers'
		Value		= $PSStandardMembers
		Force		= $True
	    }
	    $o | Add-Member @Params
	    Write-Output $o
	}
    }
}
