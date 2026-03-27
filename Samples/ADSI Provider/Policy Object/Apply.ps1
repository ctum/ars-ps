# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
#
# DN of Policy Object (PO)
	$PolicyObjectDN = "CN=TestPolicy,CN=Administration,CN=Policies,CN=Configuration"
# DN of a directory object to which you want to apply the PO
	#$ObjectToApplyDN = "EDMS://OU=Sales,DC=mycompany,DC=com"
	$ObjectToApplyDN = "OU=PowerShell,DC=askripnik,DC=msk,DC=qsft"
#
# -------------------------------------------------

$APLinksContainerDN = "CN=AP Links,CN=Configuration"
$APLinkType = "edsPolicyObjectLink"
 
# Construct unique Policy Object link name
$APLinkName = [Guid]::NewGuid().ToString()

Connect-QADService -Proxy

# Set PO GUID
$PolicyObject = Get-QADObject $PolicyObjectDN -DontUseDefaultIncludedProperties
$APOGUID = $PolicyObject.Guid.ToByteArray()

# Set managed object GUID
$ObjectToApply = Get-QADObject $ObjectToApplyDN -DontUseDefaultIncludedProperties
$SecObjectGUID = $ObjectToApply.Guid.ToByteArray()

# Create policy object link object
New-QADObject -Proxy -ParentContainer $APLinksContainerDN -Name $APLinkName -Type $APLinkType -ObjectAttributes @{"edsaAPOGUID"=$APOGUID;"edsaSecObjectGUID"=$SecObjectGUID}
