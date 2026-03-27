# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Before using the script, modify the following constants
  $strLocalFolder = "C:\Temp"
  $strShareName = "Temp"
# Set samAccountName of the computer
  $strComputer = "oakars65$"
# Set the domain NETBIOS name
  $strDomainName = "oak"
  $strShareDescription = "Temp Folder"

 
# -------------------------------------------------
 
New-QADObject $strShareName -ParentContainer "CN=Shares,CN=$strComputer,cn=$strDomainName,CN=Network" -Type "edsShare" -ObjectAttributes @{edsaSharePath=$strLocalFolder;edsaShareCreateFolder=$false;edsaShareComment=$strShareDescription} 

