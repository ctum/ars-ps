option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------
' Before using the script, modify the following constants
'
'DN of the source user
const strSourceObjectPath = "EDMS://CN=Test,Ou=Sales,DC=MyCompany,DC=com"
'The mandatory properties of the new user
const strNewUserName="CN=TestUser22"
const strObjsAMAccountName="TestUser22"
const strObjuserPrincipalName="TestUser22@mycompany.com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim ContainerObject
Dim NewUser, SourceUser
 ' Bind to the source user
Set SourceUser=GetObject(strSourceObjectPath)
 'Bind to the user parent container
Set ContainerObject=GetObject(SourceUser.Parent)
 'Copy the source user
Set NewUser=ContainerObject.CopyHere(strSourceObjectPath, strNewUserName)
 'Set the newly created user's properties
NewUser.Put "sAMAccountName", strObjsAMAccountName
NewUser.Put "userPrincipalName", strObjuserPrincipalName
 'Commit changes
NewUser.SetInfo
