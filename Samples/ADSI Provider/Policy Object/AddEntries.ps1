# PARAMETERS OF SCRIPT YOU MAY MODIFY
# -----------------------------------
#
# Before using the script, modify the following constants
#
# DN of Policy Object to which you want to add Policy Entries. This PO must exist.

$POName = "EDMS://CN=TestPolicy,CN=Administration,CN=Policies,CN=Configuration"

# First Policy Entry (property validation)
$Policy1ErrorMsg = "Corporate policy violation. The `'Name`' property value does not conform to corporate policy."
$Policy1Filter = "<PVGRules Version=`"1.0`"><PVRuleItem operator=`"*=`" linkID=`"and`"><value linkID=`"and`">%&lt;ou.ou&gt;</value></PVRuleItem></PVGRules>"
$Policy1Attribute = "cn"
$Policy1Sign = "&"
$Policy1RequiredProperty = "1"	#  Stands for TRUE
$Policy1ApplyOnto = "group"     #  The policy will only apply to Group objects.
$Policy1Description = "Validates the `'Name`' property values for `'Group`' objects."
$Policy1SkipValidation = "1"	#  Stands for TRUE

# Second Policy Entry (script policy)
$Policy2ErrorMsg = "Corporate policy violation. The requested operation cannot be performed due to a violation in policy."
# DN of a script module. This script module must exist.
$Policy2ModuleDN = "EDMS://CN=TestScriptModule,CN=Script Modules,CN=Configuration"
$Policy2Events = "0xFFFF"
$Policy2Description = "Starts the script `'TestScriptModule`' upon selected operations."

# 
# -------------------------------------------------
#
$EDS_APE_PARAM_ERROR_MSG     = 1
$EDS_APE_PARAM_FILTER        = 2
$EDS_APE_PARAM_MODULE        = 4
$EDS_APE_PARAM_ATTRIBUTE     = 40
$EDS_APE_PARAM_SIGN          = 41
$EDS_APE_PARAM_REQUIRED_PROPERTY = 43
$EDS_APE_PARAM_APPLY_ONTO    = 50
$EDS_APE_PARAM_DESCRIPTION   = 57
$EDS_APE_PARAM_GUID          = 59
$EDS_APE_PARAM_SKIP_VALIDATION = 66

$PoObject = [ADSI]$PoName

# Create a new APE
$APE = $PoObject.CreatePolicyEntry()

$APE.Type = 35

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_ERROR_MSG
$APS.Value = $Policy1ErrorMsg
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_FILTER
$APS.Value = $Policy1Filter
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_ATTRIBUTE
$APS.Value = $Policy1Attribute
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_SIGN
$APS.Value = $Policy1Sign
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_REQUIRED_PROPERTY
$APS.Value = $Policy1RequiredProperty
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_APPLY_ONTO
$APS.Value = $Policy1ApplyOnto
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_DESCRIPTION
$APS.Value = $Policy1Description
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_SKIP_VALIDATION
$APS.Value = $Policy1SkipValidation
$APE.AddPolicySetting($APS)

$PoObject.AddPolicyEntry($APE)

# Create a new APE
$APE = $PoObject.CreatePolicyEntry()

$APE.Type = 3

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_ERROR_MSG
$APS.Value = $Policy2ErrorMsg
$APE.AddPolicySetting($APS)

$ModuleObject = [ADSI]$Policy2ModuleDN
$ObjectGuid = New-Object -TypeName "System.Guid" -ArgumentList ($ModuleObject.objectGuid)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_MODULE
$APS.Value = $ObjectGuid.ToString()
$APE.AddPolicySetting($APS)

$APS = $APE.CreatePolicySetting()
$APS.Name = $EDS_APE_PARAM_DESCRIPTION
$APS.Value = $Policy2Description
$APE.AddPolicySetting($APS)

$PoObject.AddPolicyEntry($APE)

$PoObject.SetInfo()

"Done!"