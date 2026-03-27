# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
# Set samAccountName of the computer
$strComputer = "compute$"
# Set the domain NETBIOS name
$strDomainName = "domain"

# -------------------------------------------------

$ServiceObject = Get-QADObject -SearchRoot "CN=Services,cn=$strComputer,cn=$strDomainName,CN=Network" -proxy
foreach($Serv in $ServiceObject)
{
  if ($Serv.DirectoryEntry.edsaServiceStatus -eq 1) { $Status="Stopped" }
  else { $Status="Started" }
  
  Write-Host $Serv.Name   $Status  
} 


