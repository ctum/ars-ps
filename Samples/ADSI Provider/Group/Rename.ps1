# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
$strSourceGroupPath = "CN=Sales Managers,OU=Samples,DC=oak,DC=msk,DC=qsft"
$strNewGroupName ="CN=SalesStuff3"


# -------------------------------------------------

Rename-QADObject $strSourceGroupPath -NewName $strNewGroupName 