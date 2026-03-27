# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Name of MU Container
 $strContainerName = "Department 1"
 
New-QADObject -Name $strContainerName -ParentContainer "CN=Managed Units,CN=Configuration" -Type "edsManagedUnitsContainer" -proxy
