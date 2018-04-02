--author Himanshu Sharma
local BuddyResponseBuilder = {}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local Buddy = require("App42-Lua-API.Buddy")
local JSON = require("App42-Lua-API.JSON")
local Point = require("App42-Lua-API.Point")
function BuddyResponseBuilder:buildResponse(json)
  local buddy =Buddy:new()
  local buddiesJSONObj = App42ResponseBuilder:getServiceJSONObject("buddies",json)
    if buddiesJSONObj == nil then 
      buddy:setStrResponse(json)
      buddy:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    else 
      local buddyJSONObject = buddiesJSONObj.buddy
      buddy =  BuddyResponseBuilder:buildBuddyObject(buddyJSONObject)
      buddy:setStrResponse(json)
      buddy:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    end
  return buddy
end
function BuddyResponseBuilder:buildArrayResponse(responseString)
  local buddy = Buddy:new()
  local buddyJSONArray = {}
  local buddiesJSONObj = App42ResponseBuilder:getServiceJSONObject("buddies",responseString)
  local buddyJSONObjectArray = buddiesJSONObj.buddy
  if table.getn(buddyJSONObjectArray) > 0 then
    for i=1, table.getn(buddyJSONObjectArray) do
      buddy = BuddyResponseBuilder:buildBuddyObject(buddyJSONObjectArray[i])
      buddy:setStrResponse(responseString)
      buddy:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
      buddyJSONArray[i] = buddy
    end    
  else
    buddy = BuddyResponseBuilder:buildBuddyObject(buddyJSONObjectArray)
    buddy:setStrResponse(responseString)
    buddy:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
    buddyJSONArray = buddy
  end
  return buddyJSONArray
end
function BuddyResponseBuilder:buildBuddyObject(buddyJSONObject)
  local buddy  = BuddyResponseBuilder:buildObjectFromJSONTree(buddyJSONObject)
  local point = {}
  if buddyJSONObject.points ~= nil then 
    local pointsJSONObject  = buddyJSONObject.points
    local pointJSONArray = pointsJSONObject.point
    if table.getn(pointJSONArray) > 0 then
      for i=1, table.getn(pointJSONArray) do
        point[i] = BuddyResponseBuilder:buildPointObjectFromJSONTree(pointJSONArray[i])
      end
      else
        point = BuddyResponseBuilder:buildPointObjectFromJSONTree(pointJSONArray)
    end
      buddy:setPointList(point)
  end
  return buddy
end

function BuddyResponseBuilder:buildObjectFromJSONTree(json)
  local buddy =Buddy:new()
  if(json.buddyName ~= nil)then
    buddy:setBuddyName(json.buddyName)
  end
  if(json.userName ~= nil) then
    buddy:setUserName(json.userName)
  end
  if(json.groupName ~= nil) then
    buddy:setGroupName(json.groupName)
    end
  if(json.ownerName ~= nil) then
    buddy:setOwnerName(json.ownerName)
    end
  if(json.message ~= nil) then
    buddy:setMessage(json.message)
  end
  if(json.sendedOn ~= nil) then
    buddy:setSendedOn(json.sendedOn)
    end
  if(json.acceptedOn ~= nil) then
    buddy:setAcceptedOn(json.acceptedOn)
  end
  if(json.messageId ~= nil) then
    buddy:setMessageId(json.messageId)
   end
  return buddy
end
function BuddyResponseBuilder:buildPointObjectFromJSONTree(json)
  local point =Point:new()
  if(json.buddyName ~= nil)then
    point:setBuddyName(json.buddyName)
  end
  if(json.latitude ~= nil) then
    point:setLatitude(json.latitude)
  end
  if(json.markerName ~= nil) then
    point:setMarkerName(json.markerName)
    end
  if(json.createdOn ~= nil) then
    point:setCreatedOn(json.createdOn)
    end
  if(json.longitude ~= nil) then
    point:setLongitude(json.longitude)
  end
  return point
end
return BuddyResponseBuilder