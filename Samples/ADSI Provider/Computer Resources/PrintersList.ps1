 # PARAMETERS OF SCRIPT YOU MAY MODIFY
 # -----------------------------------
 #
 # Before using the script, modify the following constants
 # Set samAccountName of the computer
$strComputer = "mycomputer$"
 # Set the domain NETBIOS name
$strDomainName = "mycompany"

 # 
 # -------------------------------------------------
 #

$ContainerObject = [ADSI]"EDMS://CN=Printers,cn=$strComputer,cn=$strDomainName,CN=Network")
Result="Installed printers:`n"

foreach($Printer in $ContainerObject.Children)
{
    $Result += $Printer.Get("name") + "`n"
} 


Write-Host $Result