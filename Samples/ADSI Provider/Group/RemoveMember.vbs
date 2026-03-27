option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' Before using the script, modify the following constants
 '
 ' DN of Group
const strGroupPath = "EDMS://CN=Users,CN=Builtin,DC=mycompany,DC=com"
 ' DN of the Group member you want to remove
const strMemberPath = "CN=TestUser,DC=mycompany,DC=com"

 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------
const ADS_PROPERTY_DELETE = 4

Dim groupObject
 ' Bind to Group
Set groupObject=GetObject(strGroupPath)
 ' Remove the specified user from Group
groupObject.PutEx ADS_PROPERTY_DELETE, "member", strMemberPath
 ' Commit changes
groupObject.SetInfo
