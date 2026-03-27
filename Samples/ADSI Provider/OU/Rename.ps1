#-----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants

$strSourceOUPath = "OU=TestOU,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strNewOUName ="TestOU3"

# -------------------------------------------------

Rename-QADObject $strSourceOUPath -NewName $strNewOUName
