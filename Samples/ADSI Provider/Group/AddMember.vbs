option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' Before using the script, modify the following constants
 '
 ' DN of Group
const strGroupName = "EDMS://CN=Users,CN=Builtin,DC=mycompany,DC=com"
 ' DN of an object to be added to Group
const strNewMemberPath = "CN=TestUser,OU=Sales,DC=mycompany,DC=com"
 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------
const ADS_PROPERTY_APPEND = 3

Dim groupObject
 ' Bind to Group
Set groupObject=GetObject(strGroupName)
 ' Add a new member
groupObject.PutEx ADS_PROPERTY_APPEND, "member", strNewMemberPath
 ' Commit changes
groupObject.SetInfo
