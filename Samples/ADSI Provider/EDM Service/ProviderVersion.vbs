Dim xmlDoc, ss, NameSpace, objNode
Dim lngVersions(3)
set xmlDoc = CreateObject("Msxml2.DOMDocument")
xmlDoc.async = false
xmlDoc.resolveExternals = false
ss=""
Set NameSpace = GetObject("EDMS:")
xmlDoc.loadXML(Cstr(NameSpace.VersionInfo))

Set objNode = xmlDoc.selectSingleNode("//VersionInfo/FileVersionInfo/MajorHiVersion")
lngVersions(0) = CLng(objNode.text)
Set objNode = xmlDoc.selectSingleNode("//VersionInfo/FileVersionInfo/MajorLoVersion")
lngVersions(1) = CLng(objNode.text)
Set objNode = xmlDoc.selectSingleNode("//VersionInfo/FileVersionInfo/MinorHiVersion")
lngVersions(2) = CLng(objNode.text)
Set objNode = xmlDoc.selectSingleNode("//VersionInfo/FileVersionInfo/MinorLoVersion")
lngVersions(3) = CLng(objNode.text)
WScript.Echo "EDM ADSI provider " + CStr(lngVersions(0)) + "." + CStr(lngVersions(1)) + "."_
             + CStr(lngVersions(2)) + "." + CStr(lngVersions(3)) + " detected."
