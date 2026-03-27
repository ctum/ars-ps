# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

#DN of the container (OU)
$strContainerPath = "OU=Samples,DC=oak,DC=msk,DC=qsft"

#-------------------------------------------------

Get-QADObject -SearchRoot $strContainerPath  -Type 'user' | ForEach-Object {$_.Name}

