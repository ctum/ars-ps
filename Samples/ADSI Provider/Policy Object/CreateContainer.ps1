# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
#
# Name of PO Container to create
$ContainerName = "Restrict Policies"
# -------------------------------------------------

New-QADObject -ParentContainer "CN=Administration,CN=Policies,CN=Configuration" -Proxy -Name $ContainerName -Type "edsPolicyObjectsContainer"