option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Name of MU Container
const strContainerName= "CN=Department 1"
 ' DN of parent container	
const strParentContainerDN= "EDMS://CN=Managed Units,CN=Configuration"

 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject(strParentContainerDN)

Dim muContainerObject
Set muContainerObject = ContainerObject.Create("edsManagedUnitsContainer", strContainerName)
 ' Commit changes
muContainerObject.SetInfo
