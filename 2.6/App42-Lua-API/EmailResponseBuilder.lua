local EmailResponseBuilder={}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local JSON = require("App42-Lua-API.JSON")
local Email = require("App42-Lua-API.Email")
local Configuration= require("App42-Lua-API.Configuration")
function EmailResponseBuilder:buildResponse(json)
  local emailObj = Email:new()
  local emailJSONObj = App42ResponseBuilder:getServiceJSONObject("email",json)
    if emailJSONObj ~= nil then 
      emailObj = EmailResponseBuilder:buildEmailObject(emailJSONObj)
      emailObj:setStrResponse(json)
      emailObj:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    end
  return emailObj
end
 function EmailResponseBuilder:buildEmailObject(json)
   local email = EmailResponseBuilder:buildObjectFromJSONTree(json)
   local configList = {}
    if json.configurations ~= nil then
      local jsonObjConfigurations = json.configurations
      if jsonObjConfigurations.config ~= nil then
        local jsonConfigArray = jsonObjConfigurations.config
        if table.getn(jsonConfigArray) > 0 then
          for i=1, table.getn(jsonConfigArray) do
            configList[i] = EmailResponseBuilder:buildConfigurationObject(jsonConfigArray[i])
          end 
        else
          configList = EmailResponseBuilder:buildConfigurationObject(jsonConfigArray)
        end
        email:setConfigList(configList)
      end
    end
    return email
end
function EmailResponseBuilder:buildObjectFromJSONTree(json)
  local email = Email:new()
  if(json.from ~= nil)then
    email:setFrom(json.from)
  end
  if(json.subject ~= nil) then
    email:setSubject(json.subject)
  end
  if(json.to ~= nil) then
    email:setTo(json.to)
    end
  if(json.body ~= nil) then
    email:setBody(json.body)
    end
  return email
end
function EmailResponseBuilder:buildConfigurationObject(json)
  local configs = Configuration:new()
  if(json.emailId ~= nil)then
    configs:setEmailId(json.emailId)
  end
  if(json.host ~= nil) then
    configs:setHost(json.host)
  end
  if(json.port ~= nil) then
    configs:setPort(json.port)
    end
  if(json.ssl ~= nil) then
    configs:setSsl(json.ssl)
    end
  return configs
end

return EmailResponseBuilder