option explicit

 ' -----------------------------------
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 ' Before using the script, modify the following constants
 '
const strSourceOUPath = "EDMS://OU=TestOU,DC=mycompany,DC=com"
const strNewOUName="OU=TestOU3"
 ' -------------------------------------------------
 ' 
 ' -------------------------------------------------

Dim ContainerObject
Dim RenamedOU, SourceOU
Set SourceOU=GetObject(strSourceOUPath)
' Bind to the container where the OU resides
Set ContainerObject=GetObject(SourceOU.Parent)
' Rename OU
Set RenamedOU=ContainerObject.MoveHere(strSourceOUPath, strNewOUName)
' Commit changes
RenamedOU.SetInfo