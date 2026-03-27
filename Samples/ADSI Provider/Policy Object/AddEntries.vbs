option explicit
 ' PARAMETERS OF SCRIPT YOU MAY MODIFY
 ' -----------------------------------
 '
 ' Before using the script, modify the following constants
 '
 ' DN of Policy Object to which you want to add Policy Entries. This PO must exist.

const strPOName = "EDMS://CN=TestPolicy,CN=Administration,CN=Policies,CN=Configuration"

 ' First Policy Entry (property validation)
const strPolicy1ErrorMsg = "Corporate policy violation. The 'Name' property value does not conform to corporate policy."
const strPolicy1Filter = "<PVGRules Version=""1.0""><PVRuleItem operator=""*="" linkID=""and""><value linkID=""and"">%&lt;ou.ou&gt;</value></PVRuleItem></PVGRules>"
const strPolicy1Attribute = "cn"
const strPolicy1Sign = "&"
const strPolicy1RequiredProperty = "1"	'  Stands for TRUE
const strPolicy1ApplyOnto = "group"     '  The policy will only apply to Group objects.
const strPolicy1Description = "Validates the 'Name' property values for 'Group' objects."
const strPolicy1SkipValidation = "1"	'  Stands for TRUE

 ' Second Policy Entry (script policy)
const strPolicy2ErrorMsg = "Corporate policy violation. The requested operation cannot be performed due to a violation in policy."
 ' DN of a script module. This script module must exist.
const strPolicy2ModuleDN = "EDMS://CN=TestScriptModule,CN=Script Modules,CN=Configuration"
const strPolicy2Events = "0xFFFF"
const strPolicy2Description = "Starts the script 'TestScriptModule' upon selected operations."

 ' 
 ' -------------------------------------------------
 '
const EDS_APE_PARAM_ERROR_MSG     = 1
const EDS_APE_PARAM_FILTER        = 2
const EDS_APE_PARAM_MODULE        = 4
const EDS_APE_PARAM_ATTRIBUTE     = 40
const EDS_APE_PARAM_SIGN          = 41
const EDS_APE_PARAM_REQUIRED_PROPERTY = 43
const EDS_APE_PARAM_APPLY_ONTO    = 50
const EDS_APE_PARAM_DESCRIPTION   = 57
const EDS_APE_PARAM_GUID          = 59
const EDS_APE_PARAM_SKIP_VALIDATION = 66

Dim OctetString
Set OctetString=CreateObject("AelitaEDM.EDMOctetString")

Dim poObject
Set poObject=GetObject(strPoName)

Dim APE, APS

 ' Create a new APE
Set APE=poObject.CreatePolicyEntry


APE.Type=35

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_ERROR_MSG
APS.Value=strPolicy1ErrorMsg
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_FILTER
APS.Value=strPolicy1Filter
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_ATTRIBUTE
APS.Value=strPolicy1Attribute
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_SIGN
APS.Value=strPolicy1Sign
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_REQUIRED_PROPERTY
APS.Value=strPolicy1RequiredProperty
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_APPLY_ONTO
APS.Value=strPolicy1ApplyOnto
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_DESCRIPTION
APS.Value=strPolicy1Description
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_SKIP_VALIDATION
APS.Value=strPolicy1SkipValidation
APE.AddPolicySetting APS

poObject.AddPolicyEntry APE

 ' Create a new APE
Set APE=poObject.CreatePolicyEntry


APE.Type=3

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_ERROR_MSG
APS.Value=strPolicy2ErrorMsg
APE.AddPolicySetting APS

Dim ModuleObject
Set ModuleObject=GetObject(strPolicy2ModuleDN)
OctetString.Set ModuleObject.Guid
Set ModuleObject=Nothing

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_MODULE
APS.Value=OctetString.GetGuidString
APE.AddPolicySetting APS

Set APS=APE.CreatePolicySetting
APS.Name=EDS_APE_PARAM_DESCRIPTION
APS.Value=strPolicy2Description
APE.AddPolicySetting APS

poObject.AddPolicyEntry APE

poObject.SetInfo