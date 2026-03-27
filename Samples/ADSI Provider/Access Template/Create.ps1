# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
# Name of AT
$strATName = "TestAT"
  
# -------------------------------------------------
 
$strContainerDN = "CN=Access Templates,CN=Configuration"
New-QADObject -Name $strATName -Type "edsAccessTemplate" -ParentContainer $strContainerDN 

