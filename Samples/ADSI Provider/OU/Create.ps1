# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
# DN of Domain or OU
$strContainerDN = "OU=Samples,DC=oak,DC=msk,DC=qsft"
# Name of OU 
$strOUName = "TestOU"
 
# -------------------------------------------------

New-QADObject -Name $strOUName -ParentContainer $strContainerDN -Type "organizationalUnit"

