option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
Const strPrinterDN = "EDMS://cn=HPLaserJet2100,CN=Printers,cn=mycomputer$,cn=mycompany,CN=Network"

 ' 
 ' -------------------------------------------------
 '
Dim PrinterObject
Set PrinterObject=GetObject(strPrinterDN)

PrinterObject.Put "edsaPurgePrinter", True
PrinterObject.SetInfo
