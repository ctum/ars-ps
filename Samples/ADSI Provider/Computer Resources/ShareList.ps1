# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Before using the script, modify the following constants
# Set samAccountName of the computer
  $strComputer = "oakars65$"
# Set the domain NETBIOS name
  $strDomainName = "oak"

 
# -------------------------------------------------
 
Get-QADObject "CN=Shares,CN=$strComputer,cn=$strDomainName,CN=Network" | ForEach-Object {$_.name}

