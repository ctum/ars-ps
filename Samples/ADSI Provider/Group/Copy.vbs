option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
const strSourceGroupPath = "EDMS://CN=Sales Managers,OU=Sales,DC=mycompany,DC=com"
 ' Mandatory properties of the new group
const strNewGroupName="CN=SalesStuff2"
const strObjsAMAccountName="SalesStuff2"
 '
 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Dim NewGroup,SourceGroup
Set SourceGroup=GetObject(strSourceGroupPath)
' Bind to the container where the group resides
Set ContainerObject=GetObject(SourceGroup.Parent)
' Copy the group
Set NewGroup=ContainerObject.CopyHere(strSourceGroupPath, strNewGroupName)
' Set the group's properties
NewGroup.Put "sAMAccountName", strObjsAMAccountName
' Commit changes
NewGroup.SetInfo
