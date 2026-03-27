# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# DN of AT
$strAccessTemplateDN = "CN=TestAT,CN=Access Templates,CN=Configuration"

# Securable object - entire domain
$strObjectToSecure = "DC=oak,DC=msk,DC=qsft"

# Trustee object
$strTrusteeObject = "CN=SalesStuff,OU=Samples,DC=oak,DC=msk,DC=qsft"

# -------------------------------------------------
$strACEsContainerDN = "CN=AT Links,CN=Configuration"

New-QARSAccessTemplateLink -DirectoryObject $strTrusteeObject -AccessTemplate $strAccessTemplateDN -Trustee $strObjectToSecure

