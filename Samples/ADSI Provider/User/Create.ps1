# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants

$strContainerDN = "OU=Samples,DC=oak,DC=msk,DC=qsft"
$strUserName = "Joghn Smith"
$strsAMAccountName = "JSmith"
$strUserPrincipalName ="JSmith@mycompany.com"
# 
# -------------------------------------------------
#

$user = New-QADUser -ParentContainer $strContainerDN -Name $strUserName -SamAccountName $strsAMAccountName -UserPrincipalName $strUserPrincipalName
Enable-QADUser $user

