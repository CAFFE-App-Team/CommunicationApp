local BravoBoardResponseBuilder = {}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local BravoBoard = require("App42-Lua-API.BravoBoard")
local JSON = require("App42-Lua-API.JSON")
local Tags = require("App42-Lua-API.Tags")
function BravoBoardResponseBuilder:buildResponse(json)
  local bravoBoard =BravoBoard:new()
  local activitiesJSONObj = App42ResponseBuilder:getServiceJSONObject("activities",json)
    if activitiesJSONObj == nil then 
      bravoBoard:setStrResponse(json)
      bravoBoard:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
      bravoBoard:setTotalRecords(App42ResponseBuilder:getTotalRecords(json))
    else 
      local activityJSONObject = activitiesJSONObj.activity
      bravoBoard =  BravoBoardResponseBuilder:buildBravoObject(activityJSONObject)
      bravoBoard:setStrResponse(json)
      bravoBoard:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    end
  return bravoBoard
end
function BravoBoardResponseBuilder:buildArrayResponse(responseString)
  local bravoBoard = BravoBoard:new()
  local bravoJSONArray = {}
  local activitiesJSONObj = App42ResponseBuilder:getServiceJSONObject("activities",responseString)
  local bravoJSONObjectArray = activitiesJSONObj.activity
  if table.getn(bravoJSONObjectArray) > 0 then
    for i=1, table.getn(bravoJSONObjectArray) do
      bravoBoard = BravoBoardResponseBuilder:buildBravoObject(bravoJSONObjectArray[i])
      bravoBoard:setStrResponse(responseString)
      bravoBoard:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
      bravoJSONArray[i] = bravoBoard
    end    
  else
    bravoBoard = BravoBoardResponseBuilder:buildBravoObject(bravoJSONObjectArray)
    bravoBoard:setStrResponse(responseString)
    bravoBoard:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
    bravoJSONArray = bravoBoard
  end
  return bravoJSONArray
end
function BravoBoardResponseBuilder:buildBravoObject(bravoJSONObject)
  local bravo  = BravoBoardResponseBuilder:buildObjectFromJSONTree(bravoJSONObject)
  local tags = {}
  if bravoJSONObject.tags ~= nil then 
    local tagsJSONObject  = bravoJSONObject.tags
    if table.getn(tagsJSONObject) > 0 then
      for i=1, table.getn(tagsJSONObject) do
        tags[i] = BravoBoardResponseBuilder:buildTagsObjectFromJSONTree(tagsJSONObject[i])
      end
    else
        tags = BravoBoardResponseBuilder:buildTagsObjectFromJSONTree(tagsJSONObject)
    end
      bravo:setTagList(tags)
  end
  return bravo
end

function BravoBoardResponseBuilder:buildObjectFromJSONTree(json)
  local bravoBoard =BravoBoard:new()
  if(json.userId ~= nil)then
    bravoBoard:setUserId(json.userId)
  end
  if(json.itemId ~= nil) then
    bravoBoard:setItemId(json.itemId)
  end
  if(json.status ~= nil) then
    bravoBoard:setStatus(json.status)
    end
  if(json.comment ~= nil) then
    bravoBoard:setComment(json.comment)
    end
  if(json.createdOn ~= nil) then
    bravoBoard:setCreatedOn(json.createdOn)
    end
  if(json.activityId ~= nil) then
    bravoBoard:setActivityId(json.activityId)
  end
  return bravoBoard
end
function BravoBoardResponseBuilder:buildTagsObjectFromJSONTree(json)
  local tags =Tags:new()
  if(json.user ~= nil)then
    tags:setUser(json.user)
  end
  if(json.tagName ~= nil) then
    tags:setTagName(json.tagName)
  end
  if(json.taggedOn ~= nil) then
    tags:setTaggedOn(json.taggedOn)
  end
  return tags
end
return BravoBoardResponseBuilder