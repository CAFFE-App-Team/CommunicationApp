local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local resource = "timer"
local version = "1.0"
local TimerService =  {}


function TimerService:createOrUpdateTimer(name, timeInSeconds,callBack)
  if name == nil or name == "" or Util:trim(name) == ""  then
      Util:throwExceptionIfNullOrBlank(name,"Name", callBack)        
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the timer JSON        
      local timerJson ={}
      local app42 = {}    
      local timer =  {} 
      timerJson.name = name    
      timerJson.timeInSeconds = timeInSeconds
      timer.timer = timerJson
      app42.app42 = timer
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

function TimerService:startTimer(name, userName,callBack)
  if name == nil or name == "" or Util:trim(name) == "" or userName == nil or userName == "" or Util:trim(userName) == ""  then
      Util:throwExceptionIfNullOrBlank(name,"Name", callBack)     
      
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)     
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the timer JSON          
      local timerJson ={}
      local app42 = {}    
      local timer =  {} 
      timerJson.name = name    
      timerJson.userName = userName
      timer.timer = timerJson
      app42.app42 = timer
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.."/startTimer"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function TimerService:isTimerActive(name, userName,callBack)
  if name == nil or name == "" or Util:trim(name) == "" or userName == nil or userName == "" or Util:trim(userName) == ""  then
      Util:throwExceptionIfNullOrBlank(name,"Name", callBack) 
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)     
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the timer JSON    
      local timerJson ={}
      local app42 = {}    
      local timer =  {} 
      timerJson.name = name    
      timerJson.userName = userName
      timer.timer = timerJson
      app42.app42 = timer
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.."/isTimerActive"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function TimerService:cancelTimer(name, userName ,callBack)
  if name == nil or name == "" or Util:trim(name) == "" or userName == nil or userName == "" or Util:trim(userName) == ""  then
      Util:throwExceptionIfNullOrBlank(name,"Name", callBack) 
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)     
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {}     
    signParams.name = name 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/".. name .."/user/" .. userName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function TimerService:deleteTimer(name,callBack)
  if name == nil or name == "" or Util:trim(name) == ""  then
      Util:throwExceptionIfNullOrBlank(name,"Name", callBack)     
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {}     
    signParams.name = name 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/".. name
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function TimerService:getCurrentTime(callBack)
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/currentTime"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end

return TimerService
