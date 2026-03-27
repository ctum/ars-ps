option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
Const strLocalFolder = "C:\Temp"
Const strShareName = "Temp"
' Set samAccountName of the computer
Const strComputer = "mycomputer$"
Const strDomainNetBiosName = "mycompany"
Const strShareDescription = "Temp Folder"

 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject("EDMS://CN=Shares,CN=" + strComputer + ",cn=" + strDomainNetBiosName + ",CN=Network")
 'Create new share in the specified container
Dim ShareObject
Set ShareObject = ContainerObject.Create("edsShare", "cn="+strShareName)
 'Set properties of the newly created Computer
ShareObject.Put "cn", strShareName
ShareObject.Put "edsaSharePath", strLocalFolder
ShareObject.Put "edsaShareCreateFolder", False
ShareObject.Put "edsaShareComment", strShareDescription

ShareObject.SetInfo

