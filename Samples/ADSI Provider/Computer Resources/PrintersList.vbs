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

Set ContainerObject=GetObject("EDMS://CN=Printers,cn=" + strComputer +_
	 ",cn=" + strDomainName + ",CN=Network")

Dim Printer
Dim Result
Result="Installed printers:" + vbNewLine
For each Printer in ContainerObject
      
	Result = Result + Printer.Get("name") + vbNewLine
Next

wscript.Echo Result