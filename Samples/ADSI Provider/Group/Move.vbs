option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

'DN of the group
const strSourceObjectPath = "EDMS://CN=ManagerGroups,OU=Sales,DC=mycompany,DC=com"
'DN of the destination container
const strDestinationContainerPath = "EDMS://OU=Salesnew,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim ContainerObject
Dim NewObject

'Bind to the destination container
Set ContainerObject=GetObject(strDestinationContainerPath)
'Move the group
Set NewObject=ContainerObject.MoveHere(strSourceObjectPath, vbNullString)