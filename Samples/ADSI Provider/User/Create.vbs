option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
const strContainerDN= "EDMS://OU=Sales,DC=mycompany,DC=com"
const strUserName= "CN=Joghn Smith"
const strsAMAccountName= "JSmith"
const strUserPrincipalName="JSmith@mycompany.com"
 ' 
 ' -------------------------------------------------
 '
Dim ContainerObject
Set ContainerObject=GetObject(strContainerDN)
 'Create new user in the specified container
Dim User
Set User = ContainerObject.Create("user", strUserName)
 'Set properties of the newly created user
User.Put "sAMAccountName", strsAMAccountName
User.Put "userPrincipalName", strUserPrincipalName
User.Put "edsaNormalAccount", True
User.Put "edsaAccountIsDisabled", False
 'Commit changes
User.SetInfo
