option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'DN of the user
const strSourceObjectPath = "EDMS://CN=TestUser,OU=Sales,DC=mycompany,DC=com"
'DN of the destination container
const strDestinationContainerPath = "EDMS://OU=Software,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim ContainerObject
Dim NewObject

'Bind to the destination container
Set ContainerObject=GetObject(strDestinationContainerPath)
'Move the user
Set NewObject=ContainerObject.MoveHere(strSourceObjectPath, vbNullString)