option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' DN of the container within which the script creates Group
const strContainerDN= "EDMS://OU=Sales,DC=mycompany,DC=com"
 ' Group name
const strGroupName= "CN=SalesStuff"
const strsAMAccountName= "SalesStuff"
 ' Group type 
const intGroupType=-2147483640  ' Security Universal Group

 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
 ' Bind to the container object
Set ContainerObject=GetObject(strContainerDN)
 ' Create new Group
Dim groupObject
Set groupObject = ContainerObject.Create("group", strGroupName)
 ' Set properties of the newly created group
groupObject.Put "sAMAccountName", strsAMAccountName
groupObject.Put "groupType", intGroupType
 ' Commit changes
groupObject.SetInfo
