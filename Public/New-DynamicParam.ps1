function New-DynamicParam {
    [CmdletBinding()]
    Param (
	[Parameter(Mandatory,ValueFromPipeline)]
	[string]$ParamName,
	[Parameter(Mandatory)]
	[array]$Completions,
	[type]$Type=[string[]],
	[boolean]$Mandatory=$True,
	[boolean]$ValueFromPipeline=$False,
	[boolean]$ValueFromPipelineByPropertyName=$False,
	[string]$ParameterSetName='__AllParameterSets'
    )

    process {
	$ParamAttrib = New-Object System.Management.Automation.ParameterAttribute
	$ParamAttrib.Mandatory = $Mandatory
	$ParamAttrib.ValueFromPipeline = $ValueFromPipeline
	$ParamAttrib.ValueFromPipelineByPropertyName = $ValueFromPipelineByPropertyName
	$ParamAttrib.ParameterSetName = $ParameterSetName

	$AttribColl = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
	$AttribColl.Add($ParamAttrib)
	$AttribColl.Add(
	    (New-Object System.Management.Automation.ValidateSetAttribute($Completions))
	)
	$RuntimeParam = New-Object System.Management.Automation.RuntimeDefinedParameter(
	    $ParamName,
	    $Type,
	    $AttribColl
	)
	$RuntimeParamDic = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
	$RuntimeParamDic.Add($ParamName, $RuntimeParam)
	return $RuntimeParamDic
    }
}
