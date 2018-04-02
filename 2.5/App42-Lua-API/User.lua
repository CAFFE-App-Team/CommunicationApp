--author Himanshu Sharma
local User = {}
require("App42-Lua-API.UserGender")
local userName = nil
local email = nil
local sessionId = nil
local createdOn = nil
local json = nil
local success = false
local accountLocked = false
local profile = {}
local totalRecords
local jsonDocList = require("App42-Lua-API.JSONDocument")
function User:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function User:getUserName()
    return self.userName
end
function User:setUserName(_userName)
    self.userName = _userName  
end
function User:getEmail()
    return self.email
end
function User:setEmail(_email)
    self.email = _email  
end
function User:getSessionId()
    return self.sessionId
end
function User:setSessionId(_sessionId)
    self.sessionId = _sessionId  
end
function User:getCreatedOn()
    return self.createdOn
end
function User:setCreatedOn(_createdOn)
    self.createdOn = _createdOn  
end
function User:getProfile()
    return self.profile
end
function User:setProfile(_profile)
    self.profile = _profile  
end
function User:getStrResponse()
    return self.json
end
function User:setStrResponse(_json)
    self.json = _json  
end
function User:getAccountLocked()
    return self.accountLocked
end
function User:setAccountLocked(_accountLocked)
    self.accountLocked = _accountLocked  
end
function User:setResponseSuccess(_success)
    self.success = _success  
end
function User:getResponseSuccess()
    return self.success  
end
function User:getTotalRecords()
    return self.totalRecords
end
function User:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end
function User:getJsonDocList()
    return self.jsonDocList
end
function User:setJsonDocList(_jsonDocList)
  self.jsonDocList = _jsonDocList
end
return User