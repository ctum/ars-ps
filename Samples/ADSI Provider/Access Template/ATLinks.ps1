#Set DN of the directory object in question
$strObjDN = "CN=SalesStuff,OU=Samples,DC=oak,DC=msk,DC=qsft"

Get-QARSAccessTemplateLink -DirectoryObject $strObjDN | 
ForEach-Object { "`n`nAccess Template DN: " + $_.AccessTemplateDN + "`nTrustee: " + $_.Trustee.DN + "`nInherited from: " + $_.DirectoryObjectDN} 

