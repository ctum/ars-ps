option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 ' Name of AT Container
const strContainerName= "CN=Child ATs"
 ' DN of the parent container	
const strParentContainerDN= "EDMS://CN=Access Templates,CN=Configuration"

 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject(strParentContainerDN)

Dim atContainerObject
Set atContainerObject = ContainerObject.Create("edsAccessTemplatesContainer", strContainerName)
 'Commit changes
atContainerObject.SetInfo
