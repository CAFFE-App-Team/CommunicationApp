local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local EmailService={}
local resource = "email"
local version = "1.0"

function EmailService:createMailConfiguration(emailHost,emailPort,mailId,emailPassword, isSSL,callBack)
  if emailHost == nil or emailHost == "" or Util:trim(emailHost) == ""  or mailId == nil or mailId == "" or Util:trim(mailId) == "" or emailPassword == nil or emailPassword == "" or Util:trim(emailPassword) == ""  then
      Util:throwExceptionIfNullOrBlank(emailHost,"EmailHost", callBack)
      Util:throwExceptionIfNullOrBlank(mailId,"EmailId", callBack) 
      Util:throwExceptionIfNullOrBlank(emailPassword,"Password", callBack)  
    
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the user JSON        
      local emailJson ={}
      local app42 = {}    
      local email =  {} 
      emailJson.host = emailHost    
      emailJson.port = emailPort   
      emailJson.emailId = mailId   
      emailJson.password = emailPassword
      emailJson.ssl = isSSL
      email.email = emailJson
      app42.app42 = email
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.."/configuration"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end
function EmailService:removeEmailConfiguration(emailId,callBack)
  if emailId == nil or emailId =="" or Util:trim(emailId)=="" then
    Util:throwExceptionIfNullOrBlank(emailId,"emailId", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.emailId = emailId 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/configuration/"..emailId
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function EmailService:getEmailConfigurations(callBack)
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/configuration"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
 end

function EmailService:sendMail(sendTo,sendSubject,sendMsg,fromEmail,emailMime,callBack)
  if sendTo == nil or sendTo == "" or Util:trim(sendTo) == "" or sendSubject == nil or sendSubject == "" or  Util:trim(sendSubject) == "" or sendMsg == nil or sendMsg == "" or Util:trim(sendMsg) == "" or fromEmail == nil or fromEmail == "" or Util:trim(fromEmail) == "" then
      Util:throwExceptionIfNullOrBlank(sendTo,"SendTo", callBack)
      Util:throwExceptionIfNullOrBlank(sendSubject,"Subject", callBack)
      Util:throwExceptionIfNullOrBlank(sendMsg,"SendMsg", callBack) 
      Util:throwExceptionIfNullOrBlank(fromEmail,"fromEmail", callBack) 
    else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the user JSON        
      local emailJson ={}
      local app42 = {}    
      local email =  {} 
      emailJson.to = sendTo    
      emailJson.subject = sendSubject   
      emailJson.msg = sendMsg   
      emailJson.emailId = fromEmail
      emailJson.mimeType = emailMime
      email.email = emailJson
      app42.app42 = email
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end
return EmailService