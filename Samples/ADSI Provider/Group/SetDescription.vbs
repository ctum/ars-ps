option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constant

const strGroupDN = "EDMS://CN=SalesStuff,DC=mycompany,DC=com"
const strNewDescription = "A test group"

 ' 
 ' -------------------------------------------------
 '
Dim groupObject
 ' Bind to a group
Set groupObject=GetObject(strGroupDN)
groupObject.Put "description", strNewDescription
groupObject.SetInfo
