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

Dim ServiceObject, ServLst, Serv, St, Status
ServLst=""
Set ServiceObject=GetObject("EDMS://CN=Services,cn=" + strComputer +_
	 ",cn=" + strDomainName + ",CN=Network")

For Each Serv in ServiceObject
    Serv.GetInfoEx Array("edsaServiceStatus"),0
    St=Serv.Get("edsaServiceStatus")
    If St=1 Then
       Status="Stopped"
            Else
       Status="Started"
    End If   
    ServLst=ServLst + Serv.Name + "  " + Status + vbCRLF
Next
MsgBox ServLst