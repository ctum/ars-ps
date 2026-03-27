option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' Before using the script, modify the following constants
 ' DN of Computer
const strSourceObjectPath = "EDMS://CN=DemoPC,CN=Computers,DC=mycompany,DC=com"
 ' DN of the destination container
const strDestinationContainerPath = "EDMS://OU=TestOU,DC=mycompany,DC=com"
 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------

Dim ContainerObject
Dim NewObject

 'Bind to the destination container
Set ContainerObject=GetObject(strDestinationContainerPath)

 'Move Computer
Set NewObject=ContainerObject.MoveHere(strSourceObjectPath, vbNullString)
 'Commit changes
NewObject.SetInfo
