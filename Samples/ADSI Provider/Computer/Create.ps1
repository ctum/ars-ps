# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Before using the script, modify the following constants
$strContainerDN = "OU=Samples,DC=oak,DC=msk,DC=qsft"
$strComputerName = "DemoPC"
$strsAMAccountName = "DEMOPC$"
  
# -------------------------------------------------
 
New-QADComputer -Name $strComputerName -ParentContainer $strContainerDN -SamAccountName $strsAMAccountName 

