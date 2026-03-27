option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Name of MU
const strMUName= "CN=TestMU"
 ' 
 ' -------------------------------------------------
 '
const strContainerDN= "EDMS://CN=Managed Units,CN=Configuration"

Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)
 'Create MU
Dim muObject
Set muObject = ContainerObject.Create("edsManagedUnit", strMUName)
 'Commit changes
muObject.SetInfo
