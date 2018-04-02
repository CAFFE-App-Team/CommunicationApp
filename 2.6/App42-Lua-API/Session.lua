local Session = {}
local userName=""
local sessionId = ""
local createdOn 
local invalidatedOn
local json = nil
local success = false
local attributeList = require("App42-Lua-API.Attribute")

function Session:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Session:getUserName()
    return self.userName
end
function Session:setUserName(_userName)
  self.userName = _userName
end

function Session:getSessionId()
    return self.sessionId
end
function Session:setSessionId(_sessionId)
  self.sessionId = _sessionId
end

function Session:getCreatedOn()
    return self.createdOn
end
function Session:setCreatedOn(_createdOn)
  self.createdOn = _createdOn
end

function Session:getInvalidatedOn()
    return self.invalidatedOn
end
function Session:setInvalidatedOn(_invalidatedOn)
  self.invalidatedOn = _invalidatedOn
end

function Session:getAttributeList()
    return self.attributeList
end
function Session:setAttributeList(_attributeList)
  self.attributeList = _attributeList
end

function Session:getStrResponse()
    return self.json
end
function Session:setStrResponse(_json)
    self.json = _json  
end
function Session:setResponseSuccess(_success)
    self.success = _success  
end
function Session:getResponseSuccess()
    return self.success  
end
return Session