# Specify the operation ID 
$Operation_ID = "1-10"

#--------------------------------------------------------------

Function GetOperationStatusByID($id)
{
    $xmlOperation = FindOperationByID $id
    if ($xmlOperation -ne $null)
    {
        $GetOperationStatusByID = GetOperationStatus $xmlOperation
    }
    if ($GetOperationStatusByID -ne $null)
    {
		return $GetOperationStatusByID
    }
    return "Unknown"
}

Function GetOperationStatus($xmlOperation)
{
    if ($xmlOperation -eq $null)
    {
        return "Unknown"
    }
	$xmlDoc = [xml]$xmlOperation
	$nsmngr = New-Object "System.Xml.XmlNamespaceManager" -ArgumentList (New-Object "System.Xml.NameTable")
	$nsmngr.AddNamespace("a","urn:schemas-quest-com:ActiveRolesServer")
	$xmlNode = $xmlDoc.selectSingleNode("/a:Operation/@status", $nsmngr)
	if ($xmlNode -eq $null) 
	{
        return "Unknown"
	}
	return $xmlNode.value
}


Function FindOperationByID($id)
{
   $xmlRequest = "<OperationSearchRequest xmlns=""urn:schemas-quest-com:ActiveRolesServer"" pageSize=""1"">" + `
              "<Filter operator=""EqualityMatch"" name=""OperationID"" " + `
              "stringValue=""$id""/>" + `
              "</OperationSearchRequest>"
 
    $edmsAD = [ADSI]"EDMS://CN=Active Directory"
	$xmlResponse = $edmsAD.ExecuteRequest($xmlRequest)

	$xmlDoc = [xml]$xmlResponse
	$nt = New-Object "System.Xml.NameTable"
	$nsmngr = New-Object "System.Xml.XmlNamespaceManager" -ArgumentList $nt
	$nsmngr.AddNamespace("a","urn:schemas-quest-com:ActiveRolesServer")
	$operationNode = $xmlDoc.selectSingleNode("/a:OperationSearchResponse/a:Operations/a:Operation", $nsmngr)
 
	if ($operationNode -ne $null)
	{
		return $operationNode.OuterXml
	}
}


GetOperationStatusByID $Operation_ID 
