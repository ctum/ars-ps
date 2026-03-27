# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

#Set a mask to which the user names must match
$strSearchCondition = "Jo*"
#DN of the container where the search will start
$strSearchRoot = "OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------

Get-QADUser -Name $strSearchCondition -SearchRoot $strSearchRoot -SearchScope 'Subtree' | Disable-QADUser

