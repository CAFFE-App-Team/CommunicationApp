--author Himanshu Sharma
local JSONDocument = {}
local jsonDoc = ""
local createdAt= ""
local updatedAt= nil
local event= ""
local docId = nil
local owner = nil
local loc = require("App42-Lua-API.GeoTag")
local aclList = require("App42-Lua-API.ACL")
function JSONDocument:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function JSONDocument:getOwner()
    return self.owner
end
function JSONDocument:setOwner(_owner)
  self.owner = _owner
end
function JSONDocument:getJsonDoc()
    return self.jsonDoc
end
function JSONDocument:setJsonDoc(_jsonDoc)
  self.jsonDoc = _jsonDoc
end
function JSONDocument:getDocId()
    return self.docId
end
function JSONDocument:setDocId(_docId)
  self.docId = _docId
end
function JSONDocument:getCreatedAt()
    return self.createdAt
end
function JSONDocument:setCreatedAt(_createdAt)
  self.createdAt = _createdAt
end
function JSONDocument:getUpdatedAt()
    return self.updatedAt
end
function JSONDocument:setUpdatedAt(_updatedAt)
  self.updatedAt = _updatedAt
end
function JSONDocument:getLocation()
    return self.loc
end
function JSONDocument:setLocation(_loc)
  self.loc = _loc
end
function JSONDocument:getEvent()
    return self.event
end
function JSONDocument:setEvent(_event)
  self.event = _event
end
function JSONDocument:getAclList()
    return self.aclList
end
function JSONDocument:setAclList(_aclList)
  self.aclList = _aclList
end
return JSONDocument