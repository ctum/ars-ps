# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants
# Mask for the OU name
$strSearchCondition = "Test*"
# DN of the container where the search will start
$strSearchRoot = "OU=Samples,DC=oak,DC=msk,DC=qsft"


Get-QADObject -Name $strSearchCondition -SearchRoot $strSearchRoot -Type 'organizationalUnit' | ForEach-Object {$_.Path}

