# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------


# DN of the group
$strSourceObjectPath = "CN=Sales Managers,OU=Samples,DC=oak,DC=msk,DC=qsft"
# DN of the destination container
$strDestinationContainerPath = "OU=TestOU,OU=Samples,DC=oak,DC=msk,DC=qsft"


# -------------------------------------------------

Move-QADObject $strSourceObjectPath -NewParentContainer $strDestinationContainerPath

