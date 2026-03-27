# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Before using the script, modify the following constant
# DN of Computer
$strComputerDN = "CN=DemoPC,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strNewDescription = "A demo computer"
 
# -------------------------------------------------

Set-QADComputer $strComputerDN -Description $strNewDescription 
