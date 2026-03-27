option explicit

' -----------------------------------
' PARAMETERS OF SCRIPT YOU MAY MODIFY
' -----------------------------------
' Before using the script, modify the following constants
' DN of Computer
const strComputerDN = "EDMS://CN=DemoPC,CN=Computers,DC=mycompany,DC=com"

' -------------------------------------------------
' 
' -------------------------------------------------

Dim Computer
' Bind to Computer
Set Computer=GetObject(strComputerDN)
' Enable the computer account
Computer.Put "edsaAccountIsDisabled", false
' Commit changes
Computer.SetInfo