# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Before using the script, modify the following constants
# Name of AT Container
$strContainerName = "Child ATs"
# DN of the parent container	
$strParentContainerDN = "CN=Access Templates,CN=Configuration"

# -------------------------------------------------
New-QADObject -Name $strContainerName -Type "edsAccessTemplatesContainer" -ParentContainer $strParentContainerDN 

