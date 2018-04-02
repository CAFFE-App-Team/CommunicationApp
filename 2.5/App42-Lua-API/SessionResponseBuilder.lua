local SessionResponseBuilder = {}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local Session = require("App42-Lua-API.Session")
local Attribute = require("App42-Lua-API.Attribute")
local JSON = require("App42-Lua-API.JSON")
function SessionResponseBuilder:buildResponse(jsonString)
  local session = require("App42-Lua-API.Session")
  local sessionJSONObj = App42ResponseBuilder:getServiceJSONObject("session",jsonString)
    if(sessionJSONObj == nil) then 
      session:setStrResponse(jsonString)
      session:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
    else 
      session =  SessionResponseBuilder:buildSessionObject(sessionJSONObj)
      session:setStrResponse(jsonString)
      session:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
    end
  return session
end
function SessionResponseBuilder:buildSessionObject(sessionJSONObject)
  local session =  SessionResponseBuilder:buildObjectFromJSONTree(sessionJSONObject)
  local attributeArray = {}
  if sessionJSONObject.attributes ~= nil then
    local sessionJSONArray = sessionJSONObject.attributes.attribute
    if table.getn(sessionJSONArray) > 0 then
      for i=1, table.getn(sessionJSONArray) do
        attributeArray[i] = SessionResponseBuilder:buildAttributeObject(sessionJSONArray[i])
      end 
    else
        attributeArray = SessionResponseBuilder:buildAttributeObject(sessionJSONArray)
    end
      session:setAttributeList(attributeArray)
  end
  return session
end
function SessionResponseBuilder:buildAttributeObject(jsonObject)
  local attributeList = Attribute:new();
  if(jsonObject.name ~= nil)then
    attributeList:setName(jsonObject.name)
  end
  if(jsonObject.value ~= nil) then
    attributeList:setValue(jsonObject.value)
  end
  return attributeList
end
function SessionResponseBuilder:buildObjectFromJSONTree(jsonObject)
  local object  = Session:new()
  if(jsonObject.userName ~= nil)then
    object:setUserName(jsonObject.userName)
  end
  if(jsonObject.sessionId ~= nil) then
    object:setSessionId(jsonObject.sessionId)
  end
  if(jsonObject.createdOn ~= nil) then
    object:setCreatedOn(jsonObject.createdOn)
  end
  if(jsonObject.invalidatedOn ~= nil) then
    object:setInvalidatedOn(jsonObject.invalidatedOn)
  end
  return object
end
return SessionResponseBuilder