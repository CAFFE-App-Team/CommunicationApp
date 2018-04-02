--author Himanshu Sharma
local RestConnector = {}
local PushNotificationResponseBuilder  = require("App42-Lua-API.PushNotificationResponseBuilder")
local StorageResponseBuilder  = require("App42-Lua-API.StorageResponseBuilder")
local App42ExceptionRequest = require("App42-Lua-API.App42ExceptionRequest")
local RewardResponseBuilder  = require("App42-Lua-API.RewardResponseBuilder")
local GameResponseBuilder  = require("App42-Lua-API.GameResponseBuilder")
local App42ResponseBuilder  = require("App42-Lua-API.App42ResponseBuilder")
local UserResponseBuilder  = require("App42-Lua-API.UserResponseBuilder")
local SessionResponseBuilder  = require("App42-Lua-API.SessionResponseBuilder")
local SocialResponseBuilder = require("App42-Lua-API.SocialResponseBuilder")
local TimerResponseBuilder = require("App42-Lua-API.TimerResponseBuilder")
local EmailResponseBuilder = require("App42-Lua-API.EmailResponseBuilder")
local UploadResponseBuilder = require("App42-Lua-API.UploadResponseBuilder")
local BravoBoardResponseBuilder = require("App42-Lua-API.BravoBoardResponseBuilder")
local BuddyResponseBuilder = require("App42-Lua-API.BuddyResponseBuilder")
local GeoResponseBuilder = require("App42-Lua-API.GeoResponseBuilder")
local App42Service = require("App42-Lua-API.App42Service")
local App42Config = require("App42-Lua-API.App42Config")
local App42Log = require("App42-Lua-API.App42Log")
local MultipartFormData = require("App42-Lua-API.MultipartFormData")
local Util = require ("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local resource = ""
function RestConnector:executePost(resourceUrl,queryParams,bodyPayLoad,headerParams,callBack)
  local paramsRequest = {}
  local baseURL = App42Config:getBaseURL()
  local queryString = "?"..Util:buildQueryString(queryParams)
  local populateHeaders  = App42Service:populateHeaders(headerParams)
  populateHeaders.resource = nil
  paramsRequest.headers = populateHeaders
  paramsRequest.body = bodyPayLoad
  local encodedURL = string.gsub(Util:urlEncode(resourceUrl),"%W2F","/")
  local uri  = baseURL.. string.gsub(encodedURL,"+","%%20")..queryString
  App42Log:debug("uri is : "..uri)
  local handler = function (event)
  local exceptionObject = {}
    if event.isError == true then 
      exceptionObject = RestConnector:exceptionRequest(event,headerParams)
      if callBack.onException ~= nil then
        callBack:onException(exceptionObject)
      end
    else
      local jsonDecode = JSON:decode(event.response)
        if jsonDecode.app42 ~= nil then 
          local responseObject = RestConnector:successRequest(event,headerParams)
            if callBack.onSuccess ~= nil then
              callBack:onSuccess(responseObject)
            end
        else 
          exceptionObject = RestConnector:exceptionRequest(event,headerParams)
          if callBack.onException ~= nil then
            callBack:onException(exceptionObject)
          end
        end
      end
    end
  network.request(uri, "POST", handler ,paramsRequest)
end
 function RestConnector:executeCustomCode(resourceUrl,queryParams,bodyPayLoad,headerParams,callBack)
  local paramsRequest = {}
  local baseURL = App42Config:getCustomCodeURL()
  local queryString = "?"..Util:buildQueryString(queryParams)
  local populateHeaders  = App42Service:populateHeaders(headerParams)
  populateHeaders.resource = nil
  paramsRequest.headers = populateHeaders
  paramsRequest.body = bodyPayLoad
  local encodedURL = string.gsub(Util:urlEncode(resourceUrl),"%W2F","/")
  local uri  = baseURL.. string.gsub(encodedURL,"+","%%20")..queryString
  App42Log:debug("uri is : "..uri)
  local handler = function (event)
  local exceptionObject = {}
    if event.isError == true then 
      exceptionObject = RestConnector:exceptionRequest(event,headerParams)
      if callBack.onException ~= nil then
        callBack:onException(exceptionObject)
      end
    else
      local jsonDecode = JSON:decode(event.response)
        if jsonDecode.name ~= nil then 
          if callBack.onSuccess ~= nil then
            callBack:onSuccess(jsonDecode)
          end
        else 
          exceptionObject = RestConnector:exceptionRequest(event,headerParams)
          if callBack.onException ~= nil then
            callBack:onException(exceptionObject)
          end
        end
      end
    end
  network.request(uri, "POST", handler ,paramsRequest)
end
 
function RestConnector:executePut(resourceUrl,queryParams,bodyPayLoad,headerParams,callBack)
  local baseURL = App42Config:getBaseURL()
  local paramsRequest = {}
  local queryString = "?"..Util:buildQueryString(queryParams)
  local populateHeaders  = App42Service:populateHeaders(headerParams)
  populateHeaders.resource = nil
  paramsRequest.headers = populateHeaders
  paramsRequest.body = bodyPayLoad
  local encodedURL = string.gsub(Util:urlEncode(resourceUrl),"%W2F","/")
  local uri  = baseURL.. string.gsub(encodedURL,"+","%%20")..queryString
  App42Log:debug("Requested URL is : "..uri)
  local handler = function (event)
  local exceptionObject = {}
    if event.isError == true then 
      exceptionObject = RestConnector:exceptionRequest(event,headerParams)
      if callBack.onException ~= nil then
        callBack:onException(exceptionObject)
      end
    else
      local jsonDecode = JSON:decode(event.response)
        if jsonDecode.app42 ~= nil then 
          local responseObject = RestConnector:successRequest(event,headerParams)
              print(responseObject)
            if callBack.onSuccess ~= nil then
              callBack:onSuccess(responseObject)
            end
        else 
          exceptionObject = RestConnector:exceptionRequest(event,headerParams)
          if callBack.onException ~= nil then
            callBack:onException(exceptionObject)
          end
        end
      end
    end
  network.request(uri, "PUT", handler ,paramsRequest)
end
 
 function RestConnector:executeGet(resourceUrl,queryParams,headerParams,callBack)  
  
  local baseURL = App42Config:getBaseURL()
  local paramsRequest = {}
  local queryString = "?"..Util:buildQueryString(queryParams)
  local populateHeaders  = App42Service:populateHeaders(headerParams)
  populateHeaders.isArray = nil
  populateHeaders.resource = nil
  paramsRequest.headers = populateHeaders
 local encodedURL = string.gsub(Util:urlEncode(resourceUrl),"%W2F","/")
  local uri  = baseURL.. string.gsub(encodedURL,"+","%%20")..queryString
  App42Log:debug("Request URI is : "..uri)
  local handler = function (event)
  local exceptionObject = {}
    if event.isError == true then 
      exceptionObject = RestConnector:exceptionRequest(event,headerParams)
      if callBack.onException ~= nil then
        callBack:onException(exceptionObject)
      end
    else
      local jsonDecode = JSON:decode(event.response)
        if jsonDecode.app42 ~= nil then 
          local responseObject = RestConnector:successRequest(event,headerParams)
            if callBack.onSuccess ~= nil then
              callBack:onSuccess(responseObject)
            end
        else 
          exceptionObject = RestConnector:exceptionRequest(event,headerParams)
          if callBack.onException ~= nil then
            callBack:onException(exceptionObject)
          end
        end
      end
    end
  network.request(uri, "GET", handler ,paramsRequest)
end

function RestConnector:executeDelete(resourceUrl,queryParams,headerParams,callBack)
  local baseURL = App42Config:getBaseURL()
  local paramsRequest = {}
  local queryString = "?"..Util:buildQueryString(queryParams)
  local populateHeaders  = App42Service:populateHeaders(headerParams)
  populateHeaders.resource = nil
  paramsRequest.headers = populateHeaders
  local encodedURL = string.gsub(Util:urlEncode(resourceUrl),"%W2F","/")
  local uri  = baseURL.. string.gsub(encodedURL,"+","%%20")..queryString
  App42Log:debug("Request URI is : "..uri)
  local handler = function (event)
  local exceptionObject = {}
    if event.isError == true then 
      exceptionObject = RestConnector:exceptionRequest(event,headerParams)
      if callBack.onException ~= nil then
        callBack:onException(exceptionObject)
      end
    else
      local jsonDecode = JSON:decode(event.response)
        if jsonDecode.app42 ~= nil then 
          local responseObject = RestConnector:successRequest(event,headerParams)
            if callBack.onSuccess ~= nil then
              callBack:onSuccess(responseObject)
            end
        else 
          exceptionObject = RestConnector:exceptionRequest(event,headerParams)
          if callBack.onException ~= nil then
            callBack:onException(exceptionObject)
          end
        end
      end
    end
  local net = network.request(uri, "DELETE", handler ,paramsRequest)
end

function  RestConnector:multiPartRequest(name,file,queryParams,postParams, headersParams, urlPost,accept,callBack)
local multipart = MultipartFormData:new()
local baseURL = App42Config:getBaseURL()
local queryString = "?"..Util:buildQueryString(queryParams)
local encodedURL = string.gsub(Util:urlEncode(urlPost),"%W2F","/")
local uri  = baseURL.. string.gsub(encodedURL,"+","%%20")..queryString
App42Log:debug("uri is : "..uri)
headersParams.Accept= accept
headersParams["Content-Type"]="multipart/form-data;boundary=".."**********"
for headersKey, headersValue in sortKeyByValue(headersParams) do
 multipart:addHeader(headersKey,headersValue)
  App42Log:debug("Header Key is : "..headersKey.."   Header Value is : "..JSON:encode(headersValue))
end

for postParamsKey, postParamsValue in sortKeyByValue(postParams) do
  multipart:addField(postParamsKey,postParamsValue);
end
multipart:addFile(name,file, "image/jpeg", file)
local params = {}
params.body = multipart:getBody()
params.headers = multipart:getHeaders()
local exceptionObject={}
local networkListener = function(event)
    if event.isError == true then 
      exceptionObject = RestConnector:exceptionRequest(event,headersParams)
      if callBack.onException ~= nil then
        callBack:onException(exceptionObject)
      end
    else
      local jsonDecode = JSON:decode(event.response)
        if jsonDecode.app42 ~= nil then 
         local responseObject = RestConnector:successRequest(event,headersParams)
          if callBack.onSuccess ~= nil then
              callBack:onSuccess(responseObject)
            end
        else 
          exceptionObject = RestConnector:exceptionRequest(event,headersParams)
          if callBack.onException ~= nil then
            callBack:onException(exceptionObject)
          end
        end
      end
    end   
    params.timeout = 300000
  network.request(uri, "POST", networkListener ,params)
end


function RestConnector:successRequest(event,headerParams)
    local response = {}
    local responseString = {}
    local jsonDecode = JSON:decode(event.response)
    if(jsonDecode.app42 ~= nil)then 
      if headerParams.operation then
        local storage = require("App42-Lua-API.Storage")  
          responseString  = StorageResponseBuilder:buildResponse(event.response)
        local count = responseString:getRecordCount()
        local countJSON= {}               
        local responseJson ={} 
        local app42 = {}  
          countJSON.totalRecords = count
          responseJson.response = countJSON  
          app42.app42 = responseJson
          local storageJSONObj = App42ResponseBuilder:getServiceJSONObject("storage",JSON:encode(app42))
          if(storageJSONObj == nil) then 
            storage:setStrResponse(JSON:encode(app42))
            storage:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(JSON:encode(app42)))
            storage:setTotalRecords(App42ResponseBuilder:getTotalRecords(JSON:encode(app42)))
          end   
          headerParams.resource = ""
          App42Log:setDebug(false);
          return storage
      end
    App42Log:debug("Success is : "..event.response)
      if headerParams.resource == "user" then
        if headerParams.isArray == "true" then
          response = UserResponseBuilder:buildArrayResponse(event.response)
        else 
          response  = UserResponseBuilder:buildResponse(event.response)
        end
      elseif headerParams.resource == "storage" then
        response  = StorageResponseBuilder:buildResponse(event.response)
        
        elseif headerParams.resource == "timer" then
          response = TimerResponseBuilder:buildResponse(event.response)
          
       elseif headerParams.resource == "upload" then
          response = UploadResponseBuilder:buildResponse(event.response)
          
      elseif headerParams.resource == "session" then
        response  = SessionResponseBuilder:buildResponse(event.response)  
        
         elseif headerParams.resource == "email" then
        response  = EmailResponseBuilder:buildResponse(event.response)  
        
          elseif headerParams.resource == "social" then
        response  = SocialResponseBuilder:buildResponse(event.response)  
        
      elseif headerParams.resource == "game" then
        if headerParams.isArray == "true" then
          response = GameResponseBuilder:buildArrayResponse(event.response)
        else 
          response = GameResponseBuilder:buildResponse(event.response)
        end
      elseif headerParams.resource == "game/scoreboard" then
        if headerParams.isArray == "true" then
          response = GameResponseBuilder:buildArrayResponse(event.response)
        else 
          response = GameResponseBuilder:buildResponse(event.response)
        end
      elseif headerParams.resource == "push" then
         if headerParams.isArray == "true" then
          response = PushNotificationResponseBuilder:buildArrayResponse(event.response)
        else 
          response = PushNotificationResponseBuilder:buildResponse(event.response)
        end
       elseif headerParams.resource == "game/reward" then
        if headerParams.isArray == "true" then
          response = RewardResponseBuilder:buildArrayResponse(event.response)
        else 
          response  = RewardResponseBuilder:buildResponse(event.response)
        end
          elseif headerParams.resource == "buddy" then
         if headerParams.isArray == "true" then
          response = BuddyResponseBuilder:buildArrayResponse(event.response)
        else 
          response = BuddyResponseBuilder:buildResponse(event.response)
        end 
        elseif headerParams.resource == "bravoboard" then
         if headerParams.isArray == "true" then
          response = BravoBoardResponseBuilder:buildArrayResponse(event.response)
        else 
          response = BravoBoardResponseBuilder:buildResponse(event.response)
        end  
         elseif headerParams.resource == "geo" then
         if headerParams.isArray == "true" then
          response = GeoResponseBuilder:buildArrayResponse(event.response)
        else 
          response = GeoResponseBuilder:buildResponse(event.response)
        end 
      else
        response = jsonDecode
      end
    end
    return response
end
function RestConnector:exceptionRequest(event,headersParams)
  local app42Exception ={}
  if( event.isError) then
      app42Exception = App42ExceptionRequest:buildInternalExceptionRequest("Please check your network connection")
    else
      App42Log:debug("Excpetion is : "..event.response)
      app42Exception = App42ExceptionRequest:buildExceptionRequest(event.response)
    end
  return app42Exception
end
return RestConnector