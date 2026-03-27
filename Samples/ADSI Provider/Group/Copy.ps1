 # PARAMETERS OF SCRIPT YOU MAY MODIFY
 # -----------------------------------
 #
 # Before using the script, modify the following constants
 #
$strSourceGroupPath = "EDMS://CN=Sales Managers,OU=Sales,DC=mycompany,DC=com"
 # Mandatory properties of the new group
$strNewGroupName="CN=SalesStuff2"
$strObjsAMAccountName="SalesStuff2"
 
 # 
 # -------------------------------------------------
 #

$SourceGroup = [ADSI]$strSourceGroupPath
# Bind to the container where the group resides
$ContainerObject = [ADSI]$SourceGroup.Parent
# Copy the group
$NewGroup = $ContainerObject.CopyHere($strSourceGroupPath, $strNewGroupName)
# Set the group's properties
$NewGroup.Put("sAMAccountName", $strObjsAMAccountName)
# Commit changes
$NewGroup.SetInfo()
