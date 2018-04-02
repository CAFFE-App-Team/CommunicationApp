--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local SessionService =  {}
local queryParams =   {}
local resource = "session"
local version = "1.0"

function SessionService:getSession(uName,callBack)  
  if uName == nil or uName== "" or Util:trim(uName)=="" then
     Util:throwExceptionIfNullOrBlank(uName,"User Name", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local sessionJson ={}
    local app42 = {} 
    local session =  {}  
    sessionJson.userName = uName   
    session.session = sessionJson
    app42.app42 = session
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

function SessionService:getSessionIsCreate(uName,isCreate, callBack)  
  if uName == nil or uName== "" or Util:trim(uName)=="" or isCreate == nil or isCreate== "" then
     Util:throwExceptionIfNullOrBlank(uName,"User Name", callBack)
      Util:throwExceptionIfNullOrBlank(isCreate,"IsCreate", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local sessionJson ={}
    local app42 = {} 
    local session =  {}  
    sessionJson.userName = uName   
    session.session = sessionJson
    app42.app42 = session
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/".. resource.."/"..isCreate
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SessionService:invalidate(sessionId, callBack)  
  if sessionId == nil or sessionId== "" or Util:trim(sessionId)=="" then
     Util:throwExceptionIfNullOrBlank(sessionId,"Session Id", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local sessionJson ={}
    local app42 = {} 
    local session =  {}  
    sessionJson.id = sessionId   
    session.session = sessionJson
    app42.app42 = session
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SessionService:setAttribute(sessionId, attributeName ,attributeValue ,callBack)  
  if sessionId == nil or sessionId== "" or Util:trim(sessionId)=="" then
     Util:throwExceptionIfNullOrBlank(sessionId,"Session Id", callBack)
     Util:throwExceptionIfNullOrBlank(attributeName,"Attribute Name", callBack)
     Util:throwExceptionIfNullOrBlank(attributeValue,"Attribute Value", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    signParams.sessionId = sessionId
    local sessionJson ={}
    local app42 = {} 
    local session =  {}  
    sessionJson.name = attributeName   
    sessionJson.value = attributeValue   
    session.session = sessionJson
    app42.app42 = session
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/id/"..sessionId
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SessionService:getAttribute(sessionId, attributeName,callBack)
    if sessionId == nil or sessionId == "" or Util:trim(sessionId) == "" or attributeName == nil or attributeName == "" or Util:trim(attributeName) == "" then
      Util:throwExceptionIfNullOrBlank(sessionId,"Session Id", callBack)
     Util:throwExceptionIfNullOrBlank(attributeName,"Attribute Name", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  signParams.sessionId = sessionId
  signParams.name = attributeName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource  
  headerParams.isArray = "false"
  local resourceURL = version.."/"..resource .."/id/"..sessionId.."/"..attributeName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end


function SessionService:getAllAttributes(sessionId,callBack)
    if sessionId == nil or sessionId== "" or Util:trim(sessionId)=="" then
     Util:throwExceptionIfNullOrBlank(sessionId,"Session Id", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  signParams.sessionId = sessionId
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource  
  headerParams.isArray = "false"
  local resourceURL = version.."/"..resource .."/id/"..sessionId
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end

function SessionService:removeAttribute(sessionId, attributeName,callBack)
    if sessionId == nil or sessionId== "" or Util:trim(sessionId)=="" then
     Util:throwExceptionIfNullOrBlank(sessionId,"Session Id", callBack)
     Util:throwExceptionIfNullOrBlank(attributeName,"Attribute Name", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  signParams.sessionId = sessionId
  signParams.name = attributeName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource  
  local resourceURL = version.."/"..resource .."/id/"..sessionId.."/"..attributeName
  RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
end
end


function SessionService:removeAllAttributes(sessionId,callBack)
    if sessionId == nil or sessionId== "" or Util:trim(sessionId)=="" then
     Util:throwExceptionIfNullOrBlank(sessionId,"Session Id", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  signParams.sessionId = sessionId
  signParams.name = attributeName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource  
  local resourceURL = version.."/"..resource .."/id/"..sessionId
  RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
end
end

return SessionService