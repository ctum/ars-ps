Option Explicit
'Const DomDocumentProgID = "Msxml2.DOMDocument.4.0" ' for MSXML 4.0
Const DomDocumentProgID = "Msxml2.DOMDocument.6.0" ' for MSXML 6.0
If WScript.Arguments.Length = 0 Then
 WScript.Echo "Usage: GetApprovalStatusForObject <object_dn>"
 WScript.Quit
End If
Dim g_edmsRootDSE
Set g_edmsRootDSE = GetObject("EDMS://RootDSE")
Dim guid, sid, op
guid = GetObjectGuid(WScript.Arguments(0))
sid = GetCurrentUserSid()
op = FindLastSubmittedOperation(guid, sid)
WScript.Echo GetOperationStatus(op)
'----------------------------------
Function GetOperationStatus(xmlOperation)
 Dim xmlDoc, xmlNode
 Set xmlDoc = CreateObject(DomDocumentProgID)
 xmlDoc.loadXML(xmlOperation)
 xmlDoc.setProperty "SelectionNamespaces", "xmlns:a=""urn:schemas-quest-com:ActiveRolesServer"""
 Set xmlNode = xmlDoc.selectSingleNode("/a:Operation/@status")
 If Not (xmlNode Is Nothing) Then GetOperationStatus = xmlNode.value
 If GetOperationStatus = "" Then GetOperationStatus = "Unknown"
End Function
Function FindLastSubmittedOperation(objectGuid, userSid)
 FindLastSubmittedOperation = ""
 Dim xmlRequest, xmlResponse
 xmlRequest = "<OperationSearchRequest xmlns=""urn:schemas-quest-com:ActiveRolesServer"" pageSize=""1"">"
 xmlRequest = xmlRequest &  "<Filter operator=""And"">"
 xmlRequest = xmlRequest &  "<Subfilter operator=""EqualityMatch"" name=""TargetGuid"" stringValue=""" & objectGuid & """/>"
 xmlRequest = xmlRequest &  "<Subfilter operator=""EqualityMatch"" name=""InitiatorSid"" stringValue=""" & userSid & """/>"
 xmlRequest = xmlRequest &  "<Subfilter operator=""Present"" name=""TaskCount""/>"
 xmlRequest = xmlRequest &  "</Filter>"
 xmlRequest = xmlRequest &  "</OperationSearchRequest>"
 Dim edmsAD
 Set edmsAD = GetObject("EDMS://CN=Active Directory")
 xmlResponse = edmsAD.ExecuteRequest(xmlRequest)
 Dim xmlDoc
 Set xmlDoc = CreateObject(DomDocumentProgID)
 xmlDoc.loadXML(xmlResponse)
 xmlDoc.setProperty "SelectionNamespaces", "xmlns:a=""urn:schemas-quest-com:ActiveRolesServer"""
 Dim operationNode
 Set operationNode = xmlDoc.selectSingleNode("/a:OperationSearchResponse/a:Operations/a:Operation")
 If Not (operationNode Is Nothing) Then FindLastSubmittedOperation = operationNode.xml
End Function
Function GetObjectGuid(dn)
 Dim edmsObj
 Set edmsObj = GetObject("EDMS://" & Replace(dn, "/", "\/"))
 Dim guid
 Set guid = CreateObject("AelitaEDM.EDMOctetString")
 guid.Set edmsObj.Get("objectGUID")
 GetObjectGuid = guid.GetGuidString()
End Function
Function GetCurrentUserSid()
 g_edmsRootDSE.GetInfoEx Array("edsaClientSessionDN"), 0
 Dim edmsCS
 Set edmsCS = GetObject("EDMS://" & g_edmsRootDSE.Get("edsaClientSessionDN"))
 edmsCS.GetInfoEx Array("edsvaClientSid"), 0
 Dim sid
 Set sid = CreateObject("AelitaEDM.EDMOctetString")
 sid.Set edmsCS.Get("edsvaClientSid")
 GetCurrentUserSid = sid.GetSidString()
End Function