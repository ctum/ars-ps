option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' Name of Policy Object
const strPOName= "CN=TestPolicy"
 ' 
 ' -------------------------------------------------
 '
const strContainerDN= "EDMS://CN=Administration,CN=Policies,CN=Configuration"

Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)
 'Create PO
Dim poObject
Set poObject = ContainerObject.Create("edsPolicyObject", strPOName)
 'Commit changes
poObject.SetInfo
