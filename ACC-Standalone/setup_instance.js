var instance = application.instanceName;
var instanceHost = application.arg;

setOpt("XtkSecurity_Disable_GetSetEnv", "0"); 
const CAMPAIGN_ADMIN_PASSWORD_VAR = "neo"

logInfo("Configuration script arguments: " + application.arg);
logInfo("Executing configuration for instance: " + instance);

// const CGN_IPWD        = getVar("CGN_IPWD");
// const CGN_TRACKINGSRV = getVar("CGN_TRACKINGSRV");
// const CGN_TRACKINGPWD = getVar("CGN_TRACKINGPWD");
// const CGN_TRACKINGIPWD = getVar("CGN_TRACKINGIPWD");

// const CGN_AEMPWD      = getVar("CGN_AEMPWD");
// const CGN_AEMSRVPWD   = getVar("CGN_AEMSRVPWD");
// const CGN_MID1PWD     = getVar("CGN_MID1PWD");
// const CGN_MID2PWD     = getVar("CGN_MID2PWD");
// const CGN_MCPWD       = getVar("CGN_MCPWD");
// const CGN_LDAPPWD     = getVar("CGN_LDAPPWD");
// const CGN_BESTPWD     = getVar("CGN_BESTPWD");
 
// Configuration begin 
setOpt("NmsServer_CustomerId",          "Geometrixx");
setOpt("NmsEmail_ExpOrganization",      "Geometrixx");
setOpt("XtkInstancePrefix",             "");
setOpt("NmsEmail_FromName",             "Sender name");
setOpt("NmsEmail_DefaultFromAddr",      "info@localdev.com");
setOpt("NmsEmail_ReplyToName",          "Reply name");
setOpt("NmsEmail_DefaultReplyToAddr",   "reply@localdev.com");
setOpt("NmsEmail_DefaultErrorAddr",     "bounce@localdev.com");
setOpt("NmsDelivery_ErrorAddressMasks", "*@localdev.com");
setOpt("NmsDelivery_FromAddressMasks",  "*@localdev.com");

setOperatorPwdZone("admin", CAMPAIGN_ADMIN_PASSWORD_VAR);
 
// Important: the call to setupMcAccount must come before any call to setExtAccount or
// createTrackingInstance as it sets the instance encryption key and loads the
// database ID; otherwise password encryption does not work.
 
// Setup Message Center control side
// Password must be the same for all instances in one environment
// setupMcAccount(1, "http://rt1.intranet.example.com:8080", "neo");
// setupMcAccount(2, "http://rt1.intranet.example.com:8080", "neo");
 
/* The following can be used to create a local tracking instance
logInfo("Creating tracking instance");
nms.trackingUrl.CreateTrackingInstance(
  cryptString("internal"),
  "http://"+instanceHost, // serverUrl
  "", // secureServerUrl
  "http://localhost:8080", // urlServerList
  instance,
  cryptString("admin"),
  "*"
);
/* 

// Use this one to create an External Tracking Instance
// For example, if you are configuring an instance to connect to mid-sourcing
/*
logInfo("Creating External Tracking instance");
nms.trackingUrl.RegisterExternalInstance(
    "defaultEmailMid", // internal Name of the external account connecting to mid-sourcing
    "mid-instance", // mid-sourcing tracking server name
    "", // dbId - unknown, unused
    1 // saveParams - needs to be true if you want the changes to persist.
);
setOpt("NmsTracking_Available",         1);
 */

// setOpt("XtkLdap_Server",                "ldap.example.com");
//setOpt("XtkLdap_Mechanism",             "tls");
// setOpt("XtkLdap_DNSearch",              1);
 
// setOpt("XtkLdap_AppLogin",              "uid=CampaignGroup,ou=Directory Administrators,dc=example,dc=com");
// setOpt("XtkLdap_AppPassword",           cryptString(CGN_LDAPPWD));
// setOpt("XtkLdap_DNSearchBase",          "ou=people,ou=global,dc=example,dc=com");
//setOpt("XtkLdap_DNSearchScope",         "subtree");
// setOpt("XtkLdap_DNSearchFilter",        "mail=$(login)");
// setOpt("XtkLdap_Rights",                1);
 
// setOpt("XtkLdap_RightsBase",            "ou=campaign,ou=groups,ou=services,ou=global,dc=example,dc=com");
// setOpt("XtkLdap_RightsScope",           "subtree");
// setOpt("XtkLdap_RightsFilter",          "(&(cn=camp*)(uniqueMember=$(userdn)))");
// setOpt("XtkLdap_RightsAttr",            "cn");
// setOpt("XtkLdap_RightsMask",            "(.*)");
// setOpt("XtkLdap_AutoOperator",          1);
 
// setOpt("XtkLdap_Active",                1);
 
// setOpt("NmsServer_URL",                 "http://marketing.example.com");
// setOpt("NmsServer_IntranetURL",         "http://campaign.intranet.example.com");
 
// setOperatorPwdZone("aemserver",             CGN_AEMSRVPWD);
 
/* 
setExtAccount(
  <extAccount account="mid" active="1" deliveryMode="4" label="Mid-sourcing 1"
              mirrorURL="http://mid1.example.com" name="mid1"
              server="http://mid1.intranet.example.com:8080" type="3"/>,
  CGN_MID1PWD);
setExtAccount(
  <extAccount account="mid" active="1" deliveryMode="4" label="Mid-sourcing 2"
              mirrorURL="http://mid2.example.com/m2" name="mid2"
              server="https://mid2.intranet.example.com" type="3"/>,
  CGN_MID2PWD);
   
setExtAccount( 
<extAccount account="admin" active="1" label="AEM instance"
            name="aemInstance" server="https://aemauthor.intranet.example.com:4532"
            type="12"/>,
  CGN_AEMPWD);
 
setExtAccount( 
  <extAccount active="1" deliveryMode="4"
              label="Email routing using mid-sourcing"
              multiMidProvider="1" name="defaultEmailMid"
              type="3">
    <subProvider active="true" label="Mid-sourcing 1" name="mid1"/>
    <subProvider active="true" label="Mid-sourcing 2" name="mid2"/>
  </extAccount>);
 
logInfo("Setting routing account on mailAEMContent delivery template");
xtk.session.Write(
  <delivery internalName="mailAEMContent" deliveryMode="4" _operation="update" xtkschema="nms:delivery">
    <deliveryProvider name="defaultEmailMid"/>
  </delivery>
);
 */
// Configuration end
 
logInfo("Configuration finished");
 
 
//-------------------------------------------------------------------------
// Return environment variable value
// Fails if variable not set
//-------------------------------------------------------------------------
function getVar(strName)
{
  logInfo("Reading environment variable " + strName);
  var strVal = getEnv(strName, "##NOT SET");
  if (strVal == "##NOT SET")
    logError("Variable not set");
  return strVal;
}
 
//-------------------------------------------------------------------------
// Set option value
// Javascript type of value will set option type (e.g. number => long)
//-------------------------------------------------------------------------
function setOpt(strName, value)
{
  logInfo("Setting option " + strName);
  setOption(strName, value);
}
 
//-------------------------------------------------------------------------
// Set operator password
//-------------------------------------------------------------------------
function setOperatorPwd(strOperator, strPassword)
{
  logInfo("Setting password on operator " + strOperator);
 
  if (strPassword == "")
    logWarning("Empty password detected!");
 
  var strHashedPwd = xtk.session.HashPassword(strPassword);
 
  xtk.session.Write(
    <operator type="0" name={strOperator} xtkschema="xtk:operator">
      <access password={strHashedPwd}/>
    </operator>
  );
}
 
//-------------------------------------------------------------------------
// Set external account
// strPassword is an optional argument
// the password should not be passed in the first argument
//-------------------------------------------------------------------------
function setExtAccount(elemAccount, strPassword)
{
  logInfo("Setting external account " + elemAccount.@name);
 
  if (strPassword != undefined && strPassword == "")
    logWarning("Empty password detected!");
 
  delete elemAccount.@password;
  if (strPassword && strPassword != "")
  {
    logInfo("Setting password on external account " + elemAccount.@name);
    elemAccount.@password = cryptString(strPassword);
  }
 
  elemAccount.@xtkschema = "nms:extAccount";
  xtk.session.Write(elemAccount);
}
 
//-------------------------------------------------------------------------
// Set external account for Message Center connectivity
//-------------------------------------------------------------------------
function setupMcAccount(iInstance, strServer, strPassword)
{
  logInfo("Setting up MC account for execution instance " + iInstance);
 
  var strAccountName = "mcExec" + iInstance;
 
  setExtAccount(
    <extAccount account="mc" active="1" label={"Message Center execution instance " + 1}
                name={strAccountName} executionInstanceId={iInstance} server={strServer} type="11"/>
  );
 
  var iAccountId = sqlGetInt("SELECT iExtAccountId FROM NmsExtAccount WHERE sName = $(sz)", strAccountName);
 
  logInfo("Initializing MC account");
  nms.extAccount.InitializeExecutionInstanceAccount(iAccountId, 1);
 
  logInfo("Creating the archiving workflow");
  nms.extAccount.UpdateMCSynchWkf(iAccountId);
   
  // Password can't be setup properly before InitializeExecutionInstanceAccount was called
  setExtAccount(<extAccount name={strAccountName}/>, strPassword);
}
 
//-------------------------------------------------------------------------
// Set operator password with Security Zone
//-------------------------------------------------------------------------
function setOperatorPwdZone(strOperator, strPassword)
{
  logInfo("Setting password for operator " + strOperator);
 
  if (strPassword == "")
    logWarning("Empty password detected!");
 
  var strHashedPwd = xtk.session.HashPassword(strPassword);
 
  xtk.session.Write(
    <operator type="0" name={strOperator} xtkschema="xtk:operator" securityZone="vpn" >
      <access password={strHashedPwd}/>
    </operator>
  );
}