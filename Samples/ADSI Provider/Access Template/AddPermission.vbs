option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 ' DN of Access Template
const strAccessTemplateDN = "EDMS://CN=TestAT,CN=Access Templates,CN=Configuration"
 ' 
 ' -------------------------------------------------
 '
const ACTRL_DS_READ_PROP=16
const ACTRL_DS_WRITE_PROP=32
const ACCESS_ALLOWED_ACE_TYPE=0


Dim atObject
 ' Bind to Access Template
Set atObject=GetObject(strAccessTemplateDN)
Dim NewATE
 ' Create a new Permission Entry
set NewATE=atObject.CreatePermissionEntry
 ' Set properties of the newly created Permission Entry: read/write all properties for all classes
NewATE.AteType=ACCESS_ALLOWED_ACE_TYPE     ' "Allow" ATE type
 ' Read/Write properties access mask
NewATE.AccessMask=ACTRL_DS_READ_PROP OR ACTRL_DS_WRITE_PROP    

atObject.AddPermissionEntry(NewATE)
Set NewATE=Nothing

 ' Create a new Permission Entry
set NewATE=atObject.CreatePermissionEntry
 ' Set properties of the newly created Permission Entry: write description for user
NewATE.AteType=ACCESS_ALLOWED_ACE_TYPE         ' "Allow" ATE type
 ' Write Property access mask
NewATE.AccessMask=ACTRL_DS_WRITE_PROP  
 ' Apply to User objects
NewATE.InheritedObjectTypeADsPath="EDMS://user,Schema"     
 ' Apply to description property
NewATE.ObjectTypeADsPath="EDMS://description,Schema"      
atObject.AddPermissionEntry(NewATE)
 ' Commit changes
atObject.SetInfo 
