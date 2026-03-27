option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 ' Set samAccountName of the computer
Const strComputer = "mycomputer$"
 ' Set the domain NETBIOS name
Const strDomainName = "mycompany"

 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject("EDMS://CN=Shares,CN=" + strComputer +_
	 ",cn=" + strDomainName + ",CN=Network")

Dim SharedFolder
Dim Result
Result=""
For each SharedFolder in ContainerObject
	Result = Result + SharedFolder.Get("name") + vbNewLine
Next

wscript.Echo Result