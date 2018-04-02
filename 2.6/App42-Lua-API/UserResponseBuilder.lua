--author Himanshu Sharma
local UserResponseBuilder = {}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local User = require("App42-Lua-API.User")
local Profile = require("App42-Lua-API.Profile")
local StorageResponseBuilder = require("App42-Lua-API.StorageResponseBuilder")
function UserResponseBuilder:buildResponse(json)
  local user =User:new()
  local usersJSONObj = App42ResponseBuilder:getServiceJSONObject("users",json)
    if usersJSONObj == nil then 
      user:setStrResponse(json)
      user:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
      user:setTotalRecords(App42ResponseBuilder:getTotalRecords(json))
    else 
      local userJSONObject = usersJSONObj.user
      user =  UserResponseBuilder:buildUserObject(userJSONObject)
      user:setStrResponse(json)
      user:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    end
  return user
end
function UserResponseBuilder:buildArrayResponse(responseString)
  local user = User:new()
  local userJSONArray = {}
  local usersJSONObj = App42ResponseBuilder:getServiceJSONObject("users",responseString)
  local userJSONObjectArray = usersJSONObj.user
  if table.getn(userJSONObjectArray) > 0 then
    for i=1, table.getn(userJSONObjectArray) do
      user = UserResponseBuilder:buildUserObject(userJSONObjectArray[i])
      user:setStrResponse(responseString)
      user:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
      userJSONArray[i] = user
    end    
  else
    user = UserResponseBuilder:buildUserObject(userJSONObjectArray)
    user:setStrResponse(responseString)
    user:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
    userJSONArray = user
  end
  return userJSONArray
end
function UserResponseBuilder:buildUserObject(userJSONObject)
  local user  = UserResponseBuilder:buildObjectFromJSONTree(userJSONObject)
  local documentArray = {}
  if userJSONObject.profile ~= nil then 
    local profileJSONObject = userJSONObject.profile
    local profile  = UserResponseBuilder:buildProfileObjectFromJSONTree(profileJSONObject)
    user:setProfile(profile)
  end
  if userJSONObject.jsonDoc ~= nil then
    local jsonDocArray = userJSONObject.jsonDoc
    if table.getn(jsonDocArray) > 0 then
      for i=1, table.getn(jsonDocArray) do
        documentArray[i] = StorageResponseBuilder:buildJsonDocument(jsonDocArray[i])
      end 
    else
        documentArray = StorageResponseBuilder:buildJsonDocument(jsonDocArray)
    end
      user:setJsonDocList(documentArray)
  end
  return user
end

function UserResponseBuilder:buildObjectFromJSONTree(json)
  local user =User:new()
  if(json.userName ~= nil)then
    user:setUserName(json.userName)
  end
  if(json.email ~= nil) then
    user:setEmail(json.email)
  end
  if(json.sessionId ~= nil) then
    user:setSessionId(json.sessionId)
    end
  if(json.accountLocked ~= nil) then
    user:setAccountLocked(json.accountLocked)
    end
  if(json.createdOn ~= nil) then
    user:setCreatedOn(json.createdOn)
  end
  return user
end
function UserResponseBuilder:buildProfileObjectFromJSONTree(json)
  local profile =Profile:new()
  if(json.firstName ~= nil)then
    profile:setFirstName(json.firstName)
  end
  if(json.lastName ~= nil) then
    profile:setLastName(json.lastName)
  end
  if(json.city ~= nil) then
    profile:setCity(json.city)
    end
  if(json.country ~= nil) then
    profile:setCountry(json.country)
    end
  if(json.state ~= nil) then
    profile:setState(json.state)
  end
  if(json.dateOfBirth ~= nil) then
    profile:setDateOfBirth(json.dateOfBirth)
  end
  if(json.mobile ~= nil) then
    profile:setMobile(json.mobile)
  end
  if(json.officeLandLine ~= nil) then
    profile:setOfficeLandLine(json.officeLandLine)
  end
  if(json.homeLandLine ~= nil) then
    profile:setHomeLandLine(json.homeLandLine)
  end
  if(json.line1 ~= nil) then
    profile:setLine1(json.line1)
  end
  if(json.line2 ~= nil) then
    profile:setLine2(json.line2)
  end
  if(json.pincode ~= nil) then
    profile:setPincode(json.pincode)
  end
  if(json.sex ~= nil) then
    profile:setSex(json.sex)
  end
  return profile
end
return UserResponseBuilder