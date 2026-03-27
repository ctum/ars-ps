option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
const strContainerDN= "EDMS://CN=Computers,DC=mycompany,DC=com"
const strComputerName= "CN=DemoPC"
const strsAMAccountName= "DEMOPC$"
 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)
 'Create new user in the specified container
Dim Computer
Set Computer = ContainerObject.Create("Computer", strComputerName)
 'Set properties of the newly created Computer
Computer.Put "sAMAccountName", strsAMAccountName
Computer.Put "edsaWorkstationAccount", True
Computer.Put "edsaAccountIsDisabled", True
 'Commit changes
Computer.SetInfo

