--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local PushNotificationService =  {}
local queryParams =   {}
local orderByDescending = nil 
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local aclList = {}
local adminKey = nil
local fbAccessToken = nil
local sessionId = nil
local selectKeys = {}
local otherMetaHeaders = {} 
local resource = "push"
local version = "1.0"


function PushNotificationService:storeDeviceToken(userName,deviceToken,deviceType,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or deviceToken==nil or deviceToken=="" 
    or Util:trim(deviceToken) == "" or deviceType == nil or deviceType== "" or Util:trim(deviceType)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
    Util:throwExceptionIfNullOrBlank(deviceType,"DeviceType", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName    
    pushJson.deviceToken = deviceToken
    pushJson.type = deviceType
    push.push = pushJson
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/storeDeviceToken/"..userName
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:createChannelForApp(channel,description,callBack)
  if channel==nil or channel=="" or Util:trim(channel)=="" or description==nil or description=="" or Util:trim(description)=="" then
    Util:throwExceptionIfNullOrBlank(channel,"Channel", callBack)
    Util:throwExceptionIfNullOrBlank(description,"Description", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local channelJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.name = channel  
    pushJson.description = description    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    channelJSON.channel = pushJson
    push.push = channelJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/createAppChannel"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:subscribeToChannel(channel,userName,callBack)
  if channel==nil or channel=="" or Util:trim(channel)=="" or userName==nil or userName=="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(channel,"Channel", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local channelJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.name = channel  
    pushJson.userName = userName    
    channelJSON.channel = pushJson
    push.push = channelJSON
    local jsonBody  = JSON:encode(push)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/subscribeToChannel/"..userName
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:unsubscribeFromChannel(channel,userName,callBack)
  if channel==nil or channel=="" or Util:trim(channel)=="" or userName==nil or userName=="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(channel,"Channel", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local channelJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.name = channel  
    pushJson.userName = userName  
    channelJSON.channel = pushJson
    push.push = channelJSON
    local jsonBody  = JSON:encode(push)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/unsubscribeToChannel/"..userName
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:sendPushMessageToChannel(channel,message,callBack)
  if channel==nil or channel=="" or Util:trim(channel)=="" or message==nil or message=="" or Util:trim(message)=="" then
    Util:throwExceptionIfNullOrBlank(channel,"Channel", callBack)
      Util:throwExceptionIfNullOrBlank(message,"Message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.channel = channel  
    pushJson.payload = message    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendPushMessageToChannel/"..channel
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:sendPushMessageToAll(message,callBack)
  if message==nil or message=="" or Util:trim(message)=="" then
    Util:throwExceptionIfNullOrBlank(message,"Message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.payload = message    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendPushMessageToAll"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:sendPushMessageToUser(userName,message,callBack)
  if userName==nil or userName=="" or Util:trim(userName)=="" or message==nil or message=="" or 
    Util:trim(message)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
    Util:throwExceptionIfNullOrBlank(message,"Message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName    
    pushJson.payload = message    
    pushJson.expiry = Util:getUTCFormattedTimestamp() 
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendMessage/"..userName
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:sendPushMessageToAllByType(message,deviceType,callBack)
  if message==nil or message=="" or Util:trim(message)=="" or deviceType==nil or deviceType=="" 
    or Util:trim(deviceType)=="" then
    Util:throwExceptionIfNullOrBlank(message,"Message", callBack)
    Util:throwExceptionIfNullOrBlank(deviceType,"DeviceType", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.payload = message    
    pushJson.type = deviceType    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendMessageToAllByType"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:registerAndSubscribe(userName,channelName,deviceToken,deviceType,callBack)
  if userName==nil or userName=="" or Util:trim(userName)=="" or channelName==nil or channelName=="" 
    or Util:trim(channelName)=="" or deviceToken==nil or deviceToken=="" or Util:trim(deviceToken)=="" 
    or deviceType==nil or deviceType=="" or Util:trim(deviceType)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(channelName,"ChannelName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
    Util:throwExceptionIfNullOrBlank(deviceType,"DeviceType", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName    
    pushJson.channelName = channelName    
    pushJson.deviceToken = deviceToken    
    pushJson.type = deviceType    
    push.push = pushJson
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/subscribeDeviceToChannel"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:unsubscribeDeviceToChannel(userName,channelName,deviceToken,callBack)
  if userName==nil or userName=="" or Util:trim(userName)=="" or channelName==nil or channelName=="" 
    or Util:trim(channelName)=="" or deviceToken==nil or deviceToken=="" or Util:trim(deviceToken)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(channelName,"ChannelName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName    
    pushJson.channelName = channelName    
    pushJson.deviceToken = deviceToken 
    push.push = pushJson
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/unsubscribeDeviceToChannel"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:deleteDeviceToken(userName,deviceToken,callBack)
  if userName==nil or userName=="" or Util:trim(userName)=="" or deviceToken==nil or deviceToken=="" 
    or Util:trim(deviceToken)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    queryParams.userName = userName    
    queryParams.deviceToken = deviceToken 
    signParams.userName = userName    
    signParams.deviceToken = deviceToken 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack) 
  end
end
function PushNotificationService:sendPushMessageToGroup(message,userList,callBack)
  if message==nil or message=="" or Util:trim(message)=="" then
      Util:throwExceptionIfNullOrBlank(message,"Message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local user= {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    local users = {}
    user.user  = userList
    users.users = JSON:encode(user)
    pushJson = users 
    pushJson.payload = message    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendPushMessageToGroup"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function PushNotificationService:sendPushToTargetUsers(message, dbName,  collectionName,  query,callBack)
  if message==nil or message=="" or Util:trim(message)=="" or dbName==nil or dbName=="" or Util:trim(dbName)=="" or  collectionName==nil or collectionName=="" or Util:trim(collectionName)==""  then
    Util:throwExceptionIfNullOrBlank(message,"Message", callBack)
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
    Util:throwExceptionIfNullOrBlank(query,"query", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local queryParams =   {}
    signParams.jsonQuery= Util:queryLength(query);
    headerParams.jsonQuery= Util:queryLength(query);		
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.payload = message    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendTargetPush/"..dbName.."/"..collectionName
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function PushNotificationService:sendPushMessageToDevice(username,deviceId,message,callBack)
  if username==nil or username=="" or Util:trim(username)=="" or deviceId==nil or deviceId=="" 
    or Util:trim(deviceId)=="" or message==nil or message=="" or Util:trim(message)==""  then
    Util:throwExceptionIfNullOrBlank(username,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceId,"deviceId", callBack)
    Util:throwExceptionIfNullOrBlank(message,"message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local messageJSON = {}
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = username    
    pushJson.deviceId = deviceId    
    pushJson.payload = message    
    pushJson.expiry = Util:getUTCFormattedTimestamp()
    messageJSON.message = pushJson
    push.push = messageJSON
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/sendMessageToDevice/"..username
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function PushNotificationService:deleteAllDevices(userName,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local queryParams =   {}
    queryParams.userName = userName    
    signParams.userName = userName    
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource.."/deleteAll"
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack) 
  end
end


function PushNotificationService:unsubscribeDevice(userName,deviceToken,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  or deviceToken==nil or deviceToken=="" or Util:trim(deviceToken)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName      
    pushJson.deviceToken = deviceToken 
    push.push = pushJson
    local jsonBody  = JSON:encode(push)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/unsubscribeDevice"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function PushNotificationService:resubscribeDevice(userName,deviceToken,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  or deviceToken==nil or deviceToken=="" or Util:trim(deviceToken)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName      
    pushJson.deviceToken = deviceToken 
    push.push = pushJson
    local jsonBody  = JSON:encode(push)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/reSubscribeDevice"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function PushNotificationService:updatePushBadgeforDevice(userName,deviceToken,badges,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  or deviceToken==nil or deviceToken=="" or Util:trim(deviceToken)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName      
    pushJson.deviceToken = deviceToken   
    pushJson.increment = badges 
    push.push = pushJson
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/resetPushBadgeforDevice"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function PushNotificationService:updatePushBadgeforUser(userName,badges,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName     
    pushJson.increment = badges 
    push.push = pushJson
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/resetPushBadgeforUser"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end


function PushNotificationService:clearAllBadgeCount(userName,deviceToken,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  or deviceToken==nil or deviceToken=="" or Util:trim(deviceToken)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(deviceToken,"DeviceToken", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    local pushJson ={}
    local app42 = {} 
    local push =  {} 
    pushJson.userName = userName      
    pushJson.deviceToken = deviceToken   
    pushJson.increment = 0 
    push.push = pushJson
    app42.app42 = push
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/resetPushBadgeforDevice"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end


function PushNotificationService:deleteChannel(channelName,callBack)
  if channelName == nil or channelName =="" or Util:trim(channelName)=="" then
    Util:throwExceptionIfNullOrBlank(channelName,"channelName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.channelName = channelName 
     queryParams.channelName = channelName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/deleteChannel" 
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function PushNotificationService:getChannelUsersCount(channelName ,callBack)
  if channelName == nil or channelName =="" or Util:trim(channelName)=="" then
    Util:throwExceptionIfNullOrBlank(channelName,"channelName", callBack)
   else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.channelName = channelName 
    queryParams.channelName = channelName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    local resourceURL = version.."/"..resource.."/count/channel"
    headerParams.resource = resource
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end


function PushNotificationService:getChannelUsers(channelName, max,offset ,callBack)
  if channelName == nil or channelName =="" or Util:trim(channelName)=="" then
    Util:throwExceptionIfNullOrBlank(channelName,"channelName", callBack)
   else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.channelName = channelName 
    queryParams.channelName = channelName 
    signParams.max =  max;
		signParams.offset = offset;      
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    local resourceURL = version.."/"..resource.. "/channel".. "/" ..max.. "/" .. offset  
    headerParams.isArray = "true"
    headerParams.resource = resource
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function PushNotificationService:getUserSubscribedChannelsCount(userName ,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
   else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    queryParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    local resourceURL = version.."/"..resource.."/count/userchannels"
    headerParams.resource = resource
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end


function PushNotificationService:getUserSubscribedChannels(userName, max,offset ,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
   else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    queryParams.userName = userName 
    signParams.max =  max;
		signParams.offset = offset;      
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    local resourceURL = version.."/"..resource.. "/userchannels".. "/" ..max.. "/" ..offset          
    headerParams.resource = resource
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function PushNotificationService:getAllDevicesOfUser(userName ,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
   else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    local resourceURL = version.."/"..resource.. "/getAllDevices/"..userName
    headerParams.isArray = "true"
    headerParams.resource = resource
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function PushNotificationService:getFbAccessToken()
  return fbAccessToken
end		
function PushNotificationService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function PushNotificationService:getSessionId()
  return sessionId
end		
function PushNotificationService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function PushNotificationService:getAdminKey()
  return adminKey
end		
function PushNotificationService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function PushNotificationService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function PushNotificationService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function PushNotificationService:getSelectKeys()
  return selectKeys
end		
function PushNotificationService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function PushNotificationService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function PushNotificationService:getOrderByAscending()
  return orderByAscending
end		
function PushNotificationService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function PushNotificationService:getAclList()
  return aclList
end		
function PushNotificationService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function PushNotificationService:getPageMaxRecords()
  return pageMaxRecords
end		
function PushNotificationService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function PushNotificationService:getPageOffset()
  return pageOffset
end		
function PushNotificationService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end
return PushNotificationService