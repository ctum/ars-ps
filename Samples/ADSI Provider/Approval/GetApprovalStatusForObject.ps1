if ($args.Count -eq 0)
{
	"Usage: GetApprovalStatusForObject <object_dn>"
	return
}
$dn = $args[0]

Import-Module -Name 'ActiveRolesManagementShell' -DisableNameChecking
Connect-QADService -proxy

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

Function FindLastSubmittedOperation($objectGuid, $userSid)
{
 $FindLastSubmittedOperation = ""
	$xmlRequest = "<OperationSearchRequest xmlns=""urn:schemas-quest-com:ActiveRolesServer"" pageSize=""1"">" + `
		"<Filter operator=""And"">" + `
		"<Subfilter operator=""EqualityMatch"" name=""TargetGuid"" stringValue=""$objectGuid""/>" + `
		"<Subfilter operator=""EqualityMatch"" name=""InitiatorSid"" stringValue=""$userSid""/>" + `
		"<Subfilter operator=""Present"" name=""TaskCount""/>" + `
		"</Filter></OperationSearchRequest>"

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
    return $null
}	

function GetObjectGuid($dn)
{
    $obj = Get-QADObject $dn
    return $obj.Guid.Guid # .ToString()
}

Function GetCurrentUserSid()
{
	$root = Get-QADRootDSE
	$con = Get-QADObject $root.ClientSessionDN
	$conDE = $con.DirectoryEntry # $conDE = [ADSI]$con.adspath
	$conDE.RefreshCache("edsvaClientSid")
	$sid = [byte[]]$conDE.InvokeGet("edsvaClientSid")
	$sid = New-Object "System.Security.Principal.SecurityIdentifier" -ArgumentList ($sid, 0)
	return $sid.ToString()
}


$guid = GetObjectGuid($dn)
$sid = GetCurrentUserSid
$guid
$sid
$op = FindLastSubmittedOperation $guid $sid
GetOperationStatus $op
