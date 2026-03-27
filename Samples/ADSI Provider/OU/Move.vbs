option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------
' Before using the script, modify the following constants
' DN of the existing OU
const strSourceObjectPath = "EDMS://OU=TestOU2,DC=mycompany,DC=com"

' DN of the destination container
const strDestinationContainerPath = "EDMS://OU=TestOU,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim ContainerObject
Dim NewObject

' Bind to the destination container object
Set ContainerObject=GetObject(strDestinationContainerPath)

' Move OU
Set NewObject=ContainerObject.MoveHere(strSourceObjectPath,vbNullString)
' Commit changes
NewObject.SetInfo
