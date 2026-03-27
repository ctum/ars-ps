# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants
# DN of Computer
$strSourceObjectPath = "CN=DemoPC,OU=Samples,DC=oak,DC=msk,DC=qsft"
#DN of the destination container
$strDestinationContainerPath = "CN=Computers,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Move-QADObject $strSourceObjectPath -NewParentContainer $strDestinationContainerPath 

