local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local BravoBoardService =  {}
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
local resource = "bravoboard"
local version = "1.0"


function BravoBoardService:postActivityWithItemId(userID, itemID,comment,callBack)
  
  if userID == nil or userID== "" or Util:trim(userID)=="" or itemID==nil or itemID=="" or Util:trim(itemID) == "" or  comment == nil or comment== "" or Util:trim(comment)=="" then
     Util:throwExceptionIfNullOrBlank(userID,"User ID", callBack)
    Util:throwExceptionIfNullOrBlank(itemID,"Item ID", callBack)
    Util:throwExceptionIfNullOrBlank(comment,"Comment", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local bravoJson ={}
    local app42 = {} 
    local bravo =  {}  
    bravoJson.userId = userID    
    bravoJson.itemId = itemID
    bravoJson.comment = comment
    bravo.bravo = bravoJson
    app42.app42 = bravo
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/comment"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function BravoBoardService:postActivityWithItemIdAndTag(userID, itemID,comment,tagName,callBack)
  
  if userID == nil or userID== "" or Util:trim(userID)=="" or itemID==nil or itemID=="" or Util:trim(itemID) == "" or  comment == nil or comment== "" or Util:trim(comment)==""or  tagName == nil or tagName== "" or Util:trim(tagName)==""  then
     Util:throwExceptionIfNullOrBlank(userID,"User ID", callBack)
    Util:throwExceptionIfNullOrBlank(itemID,"Item ID", callBack)
    Util:throwExceptionIfNullOrBlank(comment,"Comment", callBack)
    Util:throwExceptionIfNullOrBlank(tagName,"tagName", callBack)
  else
    local otherMetaHeaders = {};
    otherMetaHeaders.tag= tagName;
    App42Service:setOtherMetaHeaders(otherMetaHeaders);
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local bravoJson ={}
    local app42 = {} 
    local bravo =  {}  
    bravoJson.userId = userID    
    bravoJson.itemId = itemID
    bravoJson.comment = comment
    bravo.bravo = bravoJson
    app42.app42 = bravo
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/comment"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end


function BravoBoardService:postActivity(userID, comment,callBack)
  
  if userID == nil or userID== "" or Util:trim(userID)==""  or  comment == nil or comment== "" or Util:trim(comment)=="" then
     Util:throwExceptionIfNullOrBlank(userID,"User ID", callBack)
    Util:throwExceptionIfNullOrBlank(comment,"Comment", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local itemID= Util:generateKey();
    local bravoJson ={}
    local app42 = {} 
    local bravo =  {}  
    bravoJson.userId = userID    
    bravoJson.itemId = itemID
    bravoJson.comment = comment
    bravo.bravo = bravoJson
    app42.app42 = bravo
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/comment"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function BravoBoardService:postActivityWithTag(userID, comment,tagName,callBack)
  
  if userID == nil or userID== "" or Util:trim(userID)==""  or  comment == nil or comment== "" or Util:trim(comment)=="" or  tagName == nil or tagName== "" or Util:trim(tagName)=="" then
     Util:throwExceptionIfNullOrBlank(userID,"User ID", callBack)
    Util:throwExceptionIfNullOrBlank(comment,"Comment", callBack)
    Util:throwExceptionIfNullOrBlank(tagName,"tagName", callBack)
  else
    local otherMetaHeaders = {};
    otherMetaHeaders.tag= tagName;
    App42Service:setOtherMetaHeaders(otherMetaHeaders);
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local itemID= Util:generateKey();
    local bravoJson ={}
    local app42 = {} 
    local bravo =  {}  
    bravoJson.userId = userID    
    bravoJson.itemId = itemID
    bravoJson.comment = comment
    bravo.bravo = bravoJson
    app42.app42 = bravo
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/comment"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function BravoBoardService:getActivityByItem(itemId,callBack)
  if itemId == nil or itemId == "" or Util:trim(itemId) == "" then
    Util:throwExceptionIfNullOrBlank(itemId,"ItemId", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.itemId = itemId 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource .."/comment/item" .. "/" .. itemId
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BravoBoardService:getActivityByItemByPaging(itemId,max,offset,callBack)
  if itemId == nil or itemId == "" or Util:trim(itemId) == "" then
    Util:throwExceptionIfNullOrBlank(itemId,"ItemId", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.itemId = itemId 
    signParams.max = max
    signParams.offset = offset
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource .."/comment/item/".. itemId .. "/" .. max .."/" ..offset
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
function BravoBoardService:getActivityCountByItem(itemId,callBack)
   if itemId == nil or itemId == "" or Util:trim(itemId) == "" then
    Util:throwExceptionIfNullOrBlank(itemId,"ItemId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  signParams.itemId = itemId 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/comment/item/" ..itemId .."/count";
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
function BravoBoardService:getActivityCountByTag(tagName,callBack)
   if tagName == nil or tagName == "" or Util:trim(tagName) == "" then
    Util:throwExceptionIfNullOrBlank(tagName,"TagName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)  
  signParams.tagName = tagName 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/comment/tag/" .. tagName .. "/count";
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BravoBoardService:getActivityByTag(tagName,max,offset,callBack)
  if tagName == nil or tagName == "" or Util:trim(tagName) == "" then
    Util:throwExceptionIfNullOrBlank(tagName,"TagName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.tagName = tagName 
    signParams.max = max
    signParams.offset = offset
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource .. "/comment/paging/tag/" .. tagName .. "/" .. max.. "/".. offset
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function BravoBoardService:addTagToActivity( tag,activityId,userId,callBack)
  
  if tag == nil or tag== "" or Util:trim(tag)=="" or activityId==nil or activityId=="" or Util:trim(activityId) == "" or  userId == nil or userId== "" or Util:trim(userId)=="" then
     Util:throwExceptionIfNullOrBlank(tag,"Tag", callBack)
    Util:throwExceptionIfNullOrBlank(userId,"User Id", callBack)
    Util:throwExceptionIfNullOrBlank(activityId,"ActivityId", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local bravoJson ={}
    local app42 = {} 
    local bravo =  {}  
    bravoJson.tag = tag    
    bravoJson.commentId = activityId
    bravoJson.userId = userId
    bravo.bravo = bravoJson
    app42.app42 = bravo
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/addtagtocomment"
    RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function BravoBoardService:deleteActivityById(activityId,callBack)
  
  if activityId==nil or activityId=="" or Util:trim(activityId) == ""  then
    Util:throwExceptionIfNullOrBlank(activityId,"ActivityId", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.commentId = activityId
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .. "/deleteComment/" .. activityId
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end
function BravoBoardService:deleteTag(activityId, userId,tagName,callBack)
  
  if activityId==nil or activityId=="" or Util:trim(activityId) == "" or userId==nil or userId=="" or Util:trim(userId) == "" or tagName==nil or tagName=="" or Util:trim(tagName) == ""   then
    Util:throwExceptionIfNullOrBlank(activityId,"ActivityId", callBack)
    Util:throwExceptionIfNullOrBlank(userId,"userId", callBack)
    Util:throwExceptionIfNullOrBlank(tagName,"tagName", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.commentId = activityId
    signParams.userId = userId
    signParams.tagName = tagName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .. "/deleteTag/" .. activityId .. "/" .. userId .. "/" .. tagName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function BravoBoardService:getActivityByUser(userId,max,offset,callBack)
  if userId == nil or userId == "" or Util:trim(userId) == "" then
    Util:throwExceptionIfNullOrBlank(userId,"TagName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userId = userId 
    signParams.max = max
    signParams.offset = offset
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    headerParams.isArray = "true"
    local resourceURL = version.."/"..resource ..  "/activities" .."/" .. userId .. "/" .. max .. "/" .. offset
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
  end
function BravoBoardService:getActivityCountByUser(userId,callBack)
   if userId == nil or userId == "" or Util:trim(userId) == "" then
    Util:throwExceptionIfNullOrBlank(userId,"userId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)  
  signParams.userId = userId 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.. "/activity/userId/" .. userId .."/count";
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
function BravoBoardService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function BravoBoardService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end	
return BravoBoardService