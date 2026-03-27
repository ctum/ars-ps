const strCompDN="EDMS://CN=HH-W2K,OU=Domain Controllers,DC=W2KTST,DC=local"
Set objComp=GetObject(strCompDN)
objComp.GetInfoEx Array("edsaResourcesContainerDN"),0
CompRes=objComp.get("edsaResourcesContainerDN")
MsgBox "Computer resources: " + CompRes
