# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
#
# Name of Policy Object
$POName = "TestPolicy"
#
# -------------------------------------------------

New-QADObject -ParentContainer "CN=Administration,CN=Policies,CN=Configuration" -Proxy -Name $PoName -Type "edsPolicyObject"