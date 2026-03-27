option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constant
 '
 ' DN of OU
const strOUDN = "EDMS://OU=TestOU,DC=mycompany,DC=com"
const strNewDescription = "A test OU"

 ' 
 ' -------------------------------------------------
 '
Dim OUObject
 ' Bind to OU
Set OUObject=GetObject(strOUDN)
 ' Modify the OU properties
OUObject.Put "description", strNewDescription
OUObject.SetInfo
