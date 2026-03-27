Option Explicit
'Const DomDocumentProgID = "Msxml2.DOMDocument.4.0" ' for MSXML 4.0
Const DomDocumentProgID = "Msxml2.DOMDocument.6.0" ' for MSXML 6.0
' Specify the operation ID 
Const Operation_ID = "1-209"
WScript.Echo GetOperationStatusByID(Operation_ID)

'--------------------------------------------------------------

Function GetOperationStatusByID(id)
 Dim xmlOperation
 xmlOperation = FindOperationByID(id)
 If xmlOperation <> "" Then GetOperationStatusByID = GetOperationStatus(xmlOperation)
 If GetOperationStatusByID = "" Then GetOperationStatusByID = "Unknown"
End Function



Function GetOperationStatus(xmlOperation)
 Dim xmlDoc, xmlNode
 Set xmlDoc = CreateObject(DomDocumentProgID)
 xmlDoc.loadXML(xmlOperation)
 xmlDoc.setProperty "SelectionNamespaces", "xmlns:a=""urn:schemas-quest-com:ActiveRolesServer"""
 
 Set xmlNode = xmlDoc.selectSingleNode("/a:Operation/@status")
 If Not (xmlNode Is Nothing) Then GetOperationStatus = xmlNode.value
 If GetOperationStatus = "" Then GetOperationStatus = "Unknown"
End Function


Function FindOperationByID(id)
 FindOperationByID = ""

 Dim xmlRequest, xmlResponse
 xmlRequest = "<OperationSearchRequest xmlns=""urn:schemas-quest-com:ActiveRolesServer"" pageSize=""1"">"
 xmlRequest = xmlRequest &  "<Filter operator=""EqualityMatch"" name=""OperationID"" "
 xmlRequest = xmlRequest &  "stringValue=""" & id & """/>"
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
 If Not (operationNode Is Nothing) Then FindOperationByID = operationNode.xml
End Function
