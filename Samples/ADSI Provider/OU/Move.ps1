# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants
# DN of the existing OU
$strSourceObjectPath = "OU=TestOU,OU=Samples,DC=oak,DC=msk,DC=qsft"

# DN of the destination container
$strDestinationContainerPath = "DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Move-QADObject $strSourceObjectPath -NewParentContainer $strDestinationContainerPath


