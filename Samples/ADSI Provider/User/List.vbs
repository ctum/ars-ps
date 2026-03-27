option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'DN of the container (OU)
const strContainerPath = "EDMS://OU=Sales,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim ContainerObject
' Bind to the container
Set ContainerObject=GetObject(strContainerPath)
'Set filter
ContainerObject.Filter = Array("user")
'List all users in the container
Dim obj
Dim UserList
UserList = ""
For each obj in ContainerObject
	if obj.Class = "user" then UserList=UserList+obj.Name+vbNewLine
next
'Output the list
WScript.Echo UserList
