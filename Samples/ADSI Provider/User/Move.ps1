# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

#DN of the user
$strSourceObjectPath = "CN=Joghn Smith,OU=Samples,DC=oak,DC=msk,DC=qsft"
#DN of the destination container
$strDestinationContainerPath = "CN=Users,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Move-QADObject $strSourceObjectPath -NewParentContainer $strDestinationContainerPath

