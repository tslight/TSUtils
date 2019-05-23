using namespace System.Management.Automation
using namespace System.Collections.ObjectModel

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
	[string]$ParameterSetName='__AllParameterSets',
	[string]$Help='Placeholder help message'
    )

    process {
	$ParamAttrib = New-Object ParameterAttribute
	$ParamAttrib.Mandatory = $Mandatory
	$ParamAttrib.ValueFromPipeline = $ValueFromPipeline
	$ParamAttrib.ValueFromPipelineByPropertyName = $ValueFromPipelineByPropertyName
	$ParamAttrib.ParameterSetName = $ParameterSetName
	$ParamAttrib.HelpMessage = $Help

	$AttribColl = New-Object Collection[System.Attribute]
	$AttribColl.Add($ParamAttrib)
	$AttribColl.Add(
	    (New-Object ValidateSetAttribute($Completions))
	)

	$RuntimeParam = New-Object RuntimeDefinedParameter(
	    $ParamName,
	    $Type,
	    $AttribColl
	)
	$RuntimeParamDic = New-Object RuntimeDefinedParameterDictionary
	$RuntimeParamDic.Add($ParamName, $RuntimeParam)
	return $RuntimeParamDic
    }
}
