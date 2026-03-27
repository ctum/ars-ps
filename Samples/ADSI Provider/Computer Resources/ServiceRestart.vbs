option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
Const strServiceDN = "EDMS://cn=Messenger,CN=Services,cn=mycomputer$,cn=mydomain,CN=Network"

 ' 
 ' -------------------------------------------------
 '
const SERVICE_STOPPED = &H00000001

Dim ServiceObject
Set ServiceObject=GetObject(strServiceDN)

ServiceObject.Put "edsaStopService", True
ServiceObject.SetInfo

Do 
    ServiceObject.GetInfo
Loop Until CLng(ServiceObject.Get("edsaServiceStatus")) = SERVICE_STOPPED

ServiceObject.Put "edsaStartService", True
ServiceObject.SetInfo