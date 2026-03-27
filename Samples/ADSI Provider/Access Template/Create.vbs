option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 ' Name of AT
const strATName= "CN=TestAT"
 ' 
 ' -------------------------------------------------
 '
const strContainerDN= "EDMS://CN=Access Templates,CN=Configuration"

Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)
Dim atObject
Set atObject = ContainerObject.Create("edsAccessTemplate", strATName)
 'Commit changes
atObject.SetInfo
