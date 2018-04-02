--author Himanshu Sharma
local CustomCodeService = {}
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local adminKey = nil
local fbAccessToken = nil
local sessionId = nil
local otherMetaHeaders = nil 
local resource = "customCode"
local version = "1.0"
-- Runs custom code deployed in the App42 Cloud in async mode.
-- name - Name of deployed CustomCode Service
-- jsonBody - Request Body in JSON format
-- callback - Callback object for success/exception result
function CustomCodeService:runJavaCode(serviceName,jsonObject,callBack)
  if serviceName == nil or serviceName == "" or Util:trim(serviceName) =="" then
       Util:throwExceptionIfNullOrBlank(serviceName,"ServiceName", callBack)
  else
    local queryParams = {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local jsonBody  = JSON:encode(jsonObject)
    App42Log:debug("jsonBody is : "..jsonBody)
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. "run/java/" .. serviceName
    RestConnector:executeCustomCode(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end
function CustomCodeService:getFbAccessToken()
  return fbAccessToken
end		
function CustomCodeService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function CustomCodeService:getSessionId()
  return sessionId
end		
function CustomCodeService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function CustomCodeService:getAdminKey()
  return adminKey
end		
function CustomCodeService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function CustomCodeService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function CustomCodeService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
return CustomCodeService