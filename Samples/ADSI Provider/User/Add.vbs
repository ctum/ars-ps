option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' 
 ' DN of User
 const strUserPath = "EDMS://CN=Joghn Smith,Ou=Sales,DC=mycompany,DC=com"
  ' DN of Group
const strGroupName = "EDMS://CN=Sales Managers,Ou=Sales,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim Group
'Bind to the group object
Set Group=GetObject(strGroupName)
If not Group.IsMember(strUserPath) Then
     'Add User to Group
    Group.Add strUserPath
     ' Commit changes
    Group.SetInfo 
End If    