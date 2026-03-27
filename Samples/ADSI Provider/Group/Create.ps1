# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
#
# DN of the container within which the script creates Group
$strContainerDN = "OU=Samples,DC=oak,DC=msk,DC=qsft"
# Group name
$strGroupName = "SalesStuff"
$strsAMAccountName = "SalesStuff" 
# -------------------------------------------------

New-QADGroup -ParentContainer $strContainerDN -name $strGroupName -SamAccountName $strsAMAccountName -grouptype 'Security' -groupscope 'Universal' 

