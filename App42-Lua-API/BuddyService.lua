--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local Profile = require("App42-Lua-API.Point")
local BuddyService =  {}
local orderByDescending = nil
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local aclList = {}
local adminKey = nil
local fbAccessToken = nil
local sessionId = ""
local selectKeys = {}
local otherMetaHeaders = {}  
local resource = "buddy"
local version = "1.0"


function BuddyService:sendFriendRequest(userName,buddyName,message,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or buddyName == nil or buddyName == "" or 
    Util:trim(buddyName) == "" or message == nil or message == "" or Util:trim(message) == "" then
      Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
      Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
      Util:throwExceptionIfNullOrBlank(message,"Message", callBack)        
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the buddy JSON        
      local buddyJson ={}
      local app42 = {}    
      local buddy =  {} 
      buddyJson.userName = userName    
      buddyJson.message = message
      buddyJson.buddyName = buddyName
      buddy.buddy = buddyJson
      app42.app42 = buddy
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

function BuddyService:acceptFriendRequest(userName,buddyName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or buddyName == nil or buddyName == "" or 
    Util:trim(buddyName) == ""  then
      Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
      Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the buddy JSON        
      local buddyJson ={}
      local app42 = {}    
      local buddy =  {} 
      buddyJson.userName = userName   
      buddyJson.buddyName = buddyName
      buddy.buddy = buddyJson
      app42.app42 = buddy
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
function BuddyService:getFriendRequest(userName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource .."/" .. userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getAllFriends(userName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource .."/friends/" .. userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:rejectFriendRequest(userName,buddyName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or buddyName == nil or buddyName =="" or Util:trim(buddyName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.buddyName = buddyName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/".."userName".."/" ..userName.."/".."buddyName".."/"..buddyName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:createGroupByUser(userName,groupName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or groupName == nil or groupName == "" or 
    Util:trim(groupName) == ""then
      Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
      Util:throwExceptionIfNullOrBlank(groupName,"Group Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the buddy JSON        
      local buddyJson ={}
      local app42 = {}    
      local buddy =  {} 
      buddyJson.userName = userName    
      buddyJson.groupName = groupName
      buddy.buddy = buddyJson
      app42.app42 = buddy
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource .."/group"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:addFriendToGroup(userName,groupName,friendsList,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or groupName == nil or groupName == "" or 
    Util:trim(groupName) == ""then
      Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
      Util:throwExceptionIfNullOrBlank(groupName,"Group Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the buddy JSON        
      local buddyJson ={}
      local app42 = {} 
      local friends = {}
      local buddy =  {} 
      local friend = {}
      friend.friend  = friendsList
      buddyJson.userName = userName    
      buddyJson.groupName = groupName
      buddyJson.friends = JSON:encode(friend)
      buddy.buddy = buddyJson
      app42.app42 = buddy
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource      
      headerParams.isArray = "true"
      local resourceURL = version .."/".. resource .."/group/friends"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:checkedInGeoLocation(userName,pointList,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
      Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the buddy JSON        
      local buddyJson ={}
      local app42 = {} 
      local friends = {}
      local buddy =  {} 
      local point = {}
      point.point  = pointList:getJSONObject()
      buddyJson.userName = userName    
      buddyJson.points = point
      buddy.buddy = buddyJson
      app42.app42 = buddy
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource .."/checkedIn"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:getFriendsByLocation(userName,latitude, longitude, maxDistance, max, callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.maxDistance = maxDistance 
    signParams.latitude = latitude 
    signParams.longitude = longitude 
    signParams.max = max 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource.."/".."friends".."/".."location".."/"..userName.."/"..maxDistance.."/"..latitude.."/" ..longitude.."/"..max
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getAllGroups(userName, callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource.."/".."groupall".."/"..userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getAllFriendsInGroup(userName,ownerName,groupName ,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or ownerName == nil or ownerName == "" or Util:trim(ownerName) == "" or groupName == nil or groupName == "" or Util:trim(groupName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(ownerName,"Owner Name", callBack)
    Util:throwExceptionIfNullOrBlank(groupName,"Group Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.ownerName = ownerName 
    signParams.groupName = groupName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource.."/".."friends".."/"..userName.."".."/".."group".."/"..ownerName.."/"..groupName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:blockFriendRequest(userName,buddyName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or buddyName == nil or buddyName =="" or Util:trim(buddyName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.buddyName = buddyName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/".."block".."/".."userName".."/" ..userName.."/".."buddyName".."/"..buddyName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:blockUser(userName,buddyName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or buddyName == nil or buddyName =="" or Util:trim(buddyName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    -- Creating the buddy JSON        
    local queryParams = {}
    local buddyJson ={}
    local app42 = {}    
    local buddy =  {} 
    buddyJson.userName = userName  
    buddyJson.buddyName = buddyName
    buddy.buddy = buddyJson
    app42.app42 = buddy
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/".."block"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:unblockUser(userName,buddyName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or buddyName == nil or buddyName =="" or Util:trim(buddyName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    -- Creating the buddy JSON        
    local queryParams = {}
    local buddyJson ={}
    local app42 = {}    
    local buddy =  {} 
    buddyJson.userName = userName  
    buddyJson.buddyName = buddyName
    buddy.buddy = buddyJson
    app42.app42 = buddy
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/".."unblock"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:sendMessageToGroup(userName,ownerName,groupName,message,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or ownerName == nil or ownerName =="" or Util:trim(ownerName)=="" or groupName == nil or groupName =="" or Util:trim(groupName)=="" or message == nil or message =="" or Util:trim(message)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(ownerName,"Owner Name", callBack)
    Util:throwExceptionIfNullOrBlank(groupName,"Group Name", callBack)
    Util:throwExceptionIfNullOrBlank(message,"message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    -- Creating the buddy JSON        
    local queryParams = {}
    local buddyJson ={}
    local app42 = {}    
    local buddy =  {} 
    buddyJson.userName = userName  
    buddyJson.ownerName = ownerName
    buddyJson.groupName = groupName  
    buddyJson.message = message
    buddy.buddy = buddyJson
    app42.app42 = buddy
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version .."/".. resource.."/".."groupmessage"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:sendMessageToFriend(userName,buddyName,message,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or buddyName == nil or buddyName =="" or Util:trim(buddyName)=="" or message == nil or message =="" or Util:trim(message)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
    Util:throwExceptionIfNullOrBlank(message,"message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    -- Creating the buddy JSON        
    local queryParams = {}
    local buddyJson ={}
    local app42 = {}    
    local buddy =  {} 
    buddyJson.userName = userName  
    buddyJson.buddyName = buddyName
    buddyJson.message = message
    buddy.buddy = buddyJson
    app42.app42 = buddy
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/".."friendmessage"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end
function BuddyService:sendMessageToFriends(userName,message,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or message == nil or message =="" or Util:trim(message)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(message,"message", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    -- Creating the buddy JSON        
    local queryParams = {}
    local buddyJson ={}
    local app42 = {}    
    local buddy =  {} 
    buddyJson.userName = userName  
    buddyJson.message = message
    buddy.buddy = buddyJson
    app42.app42 = buddy
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version .."/".. resource.."/".."messageAll"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end

function BuddyService:getAllMessages(userName, callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource.."/".."message".."/"..userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getAllMessagesFromBuddy(userName,buddyName, callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or buddyName == nil or buddyName == "" or Util:trim(buddyName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"BuddyName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.buddyName = buddyName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource.."/".."buddyMessage".."/"..userName.."/"..buddyName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getAllMessagesFromGroup(userName,ownerName,groupName, callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or ownerName == nil or ownerName == "" or Util:trim(ownerName) == "" or groupName == nil or groupName == "" or Util:trim(groupName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(ownerName,"OwnerName", callBack)
    Util:throwExceptionIfNullOrBlank(groupName,"GroupName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.ownerName = ownerName 
    signParams.groupName = groupName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource.."/"..userName.."/".."groupMassaage".."/"..ownerName.."/"..groupName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:unFriend(userName,buddyName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or buddyName == nil or buddyName =="" or Util:trim(buddyName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(buddyName,"Buddy Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    signParams.buddyName = buddyName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/unfriend/userName/" ..userName.."/buddyName/"..buddyName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end
function BuddyService:deleteMessageById(userName,messageId,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" or messageId == nil or messageId ==""  then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(messageId,"MessageId", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    local messageIds = {}
    messageIds[0] = messageId
    signParams.messageIds = "["..messageId.."]" 
    queryParams = signParams
    signParams.userName = userName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/deleteMessageById/"..userName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end
function BuddyService:deleteMessageByIds(userName,messageIds,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams["messageIds"] = JSON:encode(messageIds) 
    queryParams = signParams
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/".."deleteMessageById".."/"..userName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:deleteAllMessages(userName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/deleteAllMessages/"..userName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getBlockedBuddyList(userName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource .."/blockedList/" .. userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BuddyService:getFbAccessToken()
  return fbAccessToken
end		
function BuddyService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function BuddyService:getSessionId()
  return sessionId
end		
function BuddyService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function BuddyService:getAdminKey()
  return adminKey
end		
function BuddyService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function BuddyService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function BuddyService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function BuddyService:getSelectKeys()
  return selectKeys
end		
function BuddyService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function BuddyService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function BuddyService:getOrderByAscending()
  return orderByAscending
end		
function BuddyService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function BuddyService:getAclList()
  return aclList
end		
function BuddyService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function BuddyService:getPageMaxRecords()
  return pageMaxRecords
end		
function BuddyService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function BuddyService:getPageOffset()
  return pageOffset
end		
function BuddyService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end

function BuddyService:setQuery(_collectionName,  metaInfoQuery)
  App42Service:setQuery(_collectionName,  metaInfoQuery)
end
function BuddyService:addJSONObject(_collectionName, _obj)
    App42Service:addJSONObject(_collectionName, _obj)
end
return BuddyService