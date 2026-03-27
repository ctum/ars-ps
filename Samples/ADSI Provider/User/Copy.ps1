# -----------------------------------
# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
# Before using the script, modify the following constants
#
#DN of the source user
$strSourceObjectPath = "EDMS://CN=Test,Ou=Sales,DC=MyCompany,DC=com"
#The mandatory properties of the new user
$strNewUserName="CN=TestUser22"
$strObjsAMAccountName="TestUser22"
$strObjuserPrincipalName="TestUser22@mycompany.com"

# -------------------------------------------------
# 
# -------------------------------------------------

 # Bind to the source user
$SourceUser = [ADSI]$strSourceObjectPath
 #Bind to the user parent container
$ContainerObject = [ADSI]$SourceUser.Parent
 #Copy the source user
$NewUser = $ContainerObject.CopyHere($strSourceObjectPath, $strNewUserName)
 #Set the newly created user's properties
$NewUser.Put("sAMAccountName", $strObjsAMAccountName)
$NewUser.Put("userPrincipalName", $strObjuserPrincipalName)
 #Commit changes
$NewUser.SetInfo()
