# Set DN of the directory object in question.
$TargetObjectDN = "CN=DistrGroup,OU=Sales,DC=mycompany,DC=com"

$APLinksContainerDN = "CN=AP Links,CN=Configuration"
$APLinkType = "edsPolicyObjectLink"

Connect-QADService -Proxy
$TargetObject = Get-QADObject $TargetObjectDN
$FoundLinks = Get-QADObject -Type $APLinkType -SearchRoot $APLinksContainerDN -SearchAttributes @{"edsaSecObjectGUID"=$TargetObject.Guid.ToString()}
"`nPolicy Objects that are linked to the object `'$TargetObjectDN`'"
foreach($FoundLink in $FoundLinks)
{
	$Guid = [Guid]$FoundLink.Item("edsaAPOGUID")
	$PolicyObject = Get-QADObject $Guid
	"Policy Object DN: " +	
	$PolicyObject.DN
	$Guid = [Guid]$FoundLink.Item("edsaSecObjectGUID")
	$InheritedObject = Get-QADObject $Guid
	"Inherited from: " +
	$InheritedObject.DN
	"----------------------------------------------------"
}