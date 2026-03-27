option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------

const strSourceGroupPath = "EDMS://CN=Sales Managers,OU=Sales,DC=mycompany,DC=com"
const strNewGroupName="CN=SalesStuff3"


' -------------------------------------------------
' 
' -------------------------------------------------

Dim ContainerObject
Dim RenamedGroup, SourceGroup
Set SourceGroup=GetObject(strSourceGroupPath)
'Bind to the container where the group resides
Set ContainerObject=GetObject(SourceGroup.Parent)
'Rename group
Set RenamedGroup=ContainerObject.MoveHere(strSourceGroupPath, strNewGroupName)
'Commit changes
RenamedGroup.SetInfo
