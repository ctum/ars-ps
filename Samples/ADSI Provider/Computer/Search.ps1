# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Set a mask to which the computers names must match
$strSearchCondition = "Demo*"
# DN of the container where the search will start
$strSearchRoot = "OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Get-QADComputer $strSearchCondition -SearchRoot $strSearchRoot 


