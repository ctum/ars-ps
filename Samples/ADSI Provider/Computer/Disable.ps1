# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants
# DN of Computer
$strComputerDN = "CN=DemoPC,OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Disable-QADComputer $strComputerDN 

