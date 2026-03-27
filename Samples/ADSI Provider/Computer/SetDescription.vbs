option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constant
 ' DN of Computer
const strComputerDN = "EDMS://CN=DemoPC,Cn=Computers,DC=mycompany,DC=com"
const strNewDescription = "A demo computer"

 ' 
 ' -------------------------------------------------
 '
Dim ComputerObject
 ' Bind to Computer
Set ComputerObject=GetObject(strComputerDN)
 ' Modify the properties of Computer
ComputerObject.Put "description", strNewDescription
 ' Commit changes
ComputerObject.SetInfo
