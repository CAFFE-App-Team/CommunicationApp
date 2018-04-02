--author Himanshu Sharma
local App42ExceptionRequest = require("App42-Lua-API.App42ExceptionRequest")
local App42Log = require("App42-Lua-API.App42Log")
local JSON = require("App42-Lua-API.JSON")
local Util = {}
function Util:buildQueryString(queryParams)
  local stringRequest = ""
    for stringKey, stringValue in sortKeyByValue(queryParams) do
      stringRequest= stringRequest..Util:urlEncode(stringKey).."="..Util:urlEncode(stringValue).."&"
      end
  return stringRequest
end

function Util:buildAclRequest(_aclList)
local __aclList = {}
  local createPermission = {}
  if table.getn(_aclList) > 1 then
    for k=1,table.getn(_aclList) do
      local userInArray = _aclList[k].user;
      local permissionInArray = _aclList[k].permission;
      createPermission[userInArray] = permissionInArray;
      __aclList = createPermission;
    end
  else
    local userInObject = _aclList.user;
    local permissionInObject = _aclList.permission;
    createPermission[userInObject] = permissionInObject;
    __aclList = createPermission
  end
  local aclList = "["..JSON:encode(__aclList).."]"
  return aclList
end
function Util:throwExceptionIfNullOrBlank(object,name,callBack)
  if object == nil then 
    local app42NullException = App42ExceptionRequest:buildInternalExceptionRequest(name.." parameter can not be null.")
      if callBack.onException ~= nil then
        callBack:onException(app42NullException)
      end
  elseif object == "" then
    local app42BlankException = App42ExceptionRequest:buildInternalExceptionRequest(name.." parameter can not be blank.")
      if callBack.onException ~= nil then
        callBack:onException(app42BlankException)
      end
  elseif Util:trim(object) == "" then
    local app42Exception = App42ExceptionRequest:buildInternalExceptionRequest(name.." parameter can not be blank.")
      if callBack.onException ~= nil then
        callBack:onException(app42Exception)
      end
  end 
end
function Util:throwExceptionIfEmailIsNotValid(object,name,callBack)
  local app42EmailInnvalidException = App42ExceptionRequest:buildInternalExceptionRequest(object.." is not valid email address.")
    if callBack.onException ~= nil then
      callBack:onException(app42EmailInnvalidException)
    end
end
function Util:isValidEmailAddress(object,callBack)
  
  if (object:match("[A-Za-z0-9%.%%%+%-]+@[A-Za-z0-9%.%%%+%-]+%.%w%w%w?%w?")== nil) then
      return false
  end
end
function Util:getUTCFormattedTimestamp() 
  local timStamp = ""
  local year  = os.date("!%Y")
  local monthString = os.date("!%m")   
  local dayString = os.date("!%d")
  local hourString = os.date("!%H")
  local minString = os.date("!%M")
  local secString = os.date("!%S")
  if(string.len(monthString) == 1) then
    monthString = "0"..monthString
  end
  if(string.len(dayString) == 1) then
    dayString = "0"..dayString
  end
  if(string.len(hourString) == 1) then
    hourString = "0"..hourString
  end
  if(string.len(minString) == 1) then
    minString = "0"..minString
  end
  if(string.len(secString) == 1) then
    secString = "0"..secString
  end
    timStamp = year.."-"..monthString.."-"..dayString.."T"..hourString..":"..minString..":"..secString..".".."000Z"
    return timStamp
 end
 
function Util:getUTCFormattedTimestampWithUserInputDate(_time) 
  local time  = _time
  local timStamp = ""
  local monthString = time.month    
  local dayString = time.day
  local hourString = time.hour
  local minString = time.min
  local secString = time.sec
  if(string.len(monthString) == 1) then
    monthString = "0"..monthString
  end
  if(string.len(dayString) == 1) then
    dayString = "0"..dayString
  end
  if(string.len(hourString) == 1) then
    hourString = "0"..hourString
  end
  if(string.len(minString) == 1) then
    minString = "0"..minString
  end
  if(string.len(secString) == 1) then
    secString = "0"..secString
  end
    timStamp = time.year.."-"..monthString.."-"..dayString.."T"..hourString..":"..minString..":"..secString..".".."000Z"
    return timStamp
 end
 
function Util:urlEncode(str)
  if (str) then
    str = string.gsub (str, "\n", "\r\n")
    str = string.gsub (str, "([^%w %-%_%.%~])",
      function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
    end
  return str	
end
 
 
function Util:sign(secretKey,signParams)
  local paramString  = ""
  App42Log:debug("SignParams is : "..JSON:encode(signParams))
    for key, value in sortKeyByValue(signParams) do
      paramString = paramString..key..value
    end
  local hmac = calculateSignature(secretKey, paramString);
  return Util:urlEncode(hmac);
end
   
function fromhex(str)
  return (str:gsub('..', function (cc)
      return string.char(tonumber(cc, 16))
  end))
end
 
function calculateSignature(secretKey, params)
  require "App42-Lua-API.sha1"
    local hexString = hmac_sha1(secretKey, params);
    local mime = require("mime")
    local base64String = mime.b64(fromhex(hexString))
    return base64String
end
function Util:queryLength(query)
  if table.getn(query) > 1 then 
    return JSON:encode(query)
  else
    return "["..JSON:encode(query).."]"
  end
end
function Util:trim(string)
  return (string.gsub(string, "^%s*(.-)%s*$", "%1"))
end
function sortKeyByValue(t, f)
  local a = {}
    for n in pairs(t) do table.insert(a, n) end
    table.sort(a, f)
  local i = 0      
  local iter = function () 
    i = i + 1
      if a[i] == nil then return nil
        else return a[i], t[a[i]]
      end
    end
  return iter
end

function Util:generateKey()
        -- Reseed the generator.
        math.randomseed(math.random(1, 100000000))
       
        -- Reseed the generator with the current time so the key generation
        -- should be even more difficult to recreate.
        local characters = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
                            'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't',
                            'u', 'v', 'w', 'x', 'y', 'z'
                           }
        local key = ""
        for index = 1, 8 do
                key = key .. math.random(0, 9) .. characters[math.random(1, 26)]
        end
       
        return key
end
 return Util