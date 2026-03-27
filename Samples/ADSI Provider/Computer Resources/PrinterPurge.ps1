
 # PARAMETERS OF SCRIPT YOU MAY MODIFY
 # -----------------------------------
 #
 # Before using the script, modify the following constants
$strPrinterDN = "EDMS://cn=HPLaserJet2100,CN=Printers,cn=mycomputer$,cn=mycompany,CN=Network"

 # 
 # -------------------------------------------------
 #
$PrinterObject = [ADSI]$strPrinterDN

$PrinterObject.Put("edsaPurgePrinter", $true)
$PrinterObject.SetInfo()
