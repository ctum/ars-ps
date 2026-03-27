option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------

const strContainerDN = "OU=Sales,DC=mycompany,DC=com"
const strOldUserName = "CN=TestUser"
const strNewUserName = "CN=TestUser3"

 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------

Dim ContainerObject
Dim NewObject, strSourceObjectPath
 ' Path to the "old" user object
strSourceObjectPath = "EDMS://"  + strOldUserName + "," + strContainerDN
 ' Bind to the container that holds the user
Set ContainerObject=GetObject("EDMS://" + strContainerDN)
 ' Rename user
Set NewObject=ContainerObject.MoveHere(strSourceObjectPath, strNewUserName)
 ' Commit changes
NewObject.SetInfo
