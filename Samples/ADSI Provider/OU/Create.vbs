option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 ' DN of Domain or OU
const strContainerDN= "EDMS://DC=mycompany,DC=com"
 ' Name of OU 
const strOUName= "OU=TestOU"
 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)
 'Create OU in the specified container
Dim ouObject
Set ouObject = ContainerObject.Create("organizationalUnit", strOUName)
 'Commit changes
ouObject.SetInfo
