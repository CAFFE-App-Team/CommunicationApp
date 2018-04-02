--author Himanshu Sharma
local Util = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local App42ResponseBuilder = {}

function App42ResponseBuilder:getServiceJSONObject(serviceName, flatstring)
  local jsonObj = JSON:decode(flatstring)
  local jsonObjApp42 = jsonObj.app42
  local jsonObjResponse = jsonObjApp42.response
  local jsonObjService = jsonObjResponse[serviceName]
  return jsonObjService
end

function App42ResponseBuilder:getResource(flatstring)
  local jsonObj = JSON:decode(flatstring)
  local jsonObjApp42 = jsonObj.app42
  local jsonObjResponse = jsonObjApp42.response
  return jsonObjResponse
end

function App42ResponseBuilder:isResponseSuccess(json)
  local jsonObj = JSON:decode(json)
  local jsonObjApp42 = jsonObj.app42
  local jsonObjResponse = jsonObjApp42.response
  local jsonObjSuccess = jsonObjResponse.success
  return jsonObjSuccess
end
function App42ResponseBuilder:getTotalRecords(json)
  local jsonObj = JSON:decode(json)
  local jsonObjApp42 = jsonObj.app42
  local jsonObjResponse = jsonObjApp42.response
  local totalRecords = jsonObjResponse.totalRecords
  return totalRecords
end
return App42ResponseBuilder