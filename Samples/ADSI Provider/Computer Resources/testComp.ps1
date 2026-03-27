$strCompDN="CN=HH-W2K,OU=Domain Controllers,DC=W2KTST,DC=local"
$comp = Get-QADComputer $strCompDN -IncludedProperties "edsaResourcesContainerDN"
$comp.edsaResourcesContainerDN