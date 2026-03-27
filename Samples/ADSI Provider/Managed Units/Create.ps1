# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------

# Name of MU
 $strMUName = "TestMU"
 
New-QADObject -Name $strMUName -ParentContainer "CN=Managed Units,CN=Configuration" -Type "edsManagedUnit" -proxy

