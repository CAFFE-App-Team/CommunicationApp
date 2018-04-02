--author Himanshu Sharma
local Buddy = {}
local userName = nil
local buddyName = nil
local groupName = nil
local ownerName = nil
local success = false
local message = nil
local json
local pointList = require("App42-Lua-API.Point")
local sendedOn = nil
local acceptedOn = nil
local messageId = nil
function Buddy:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Buddy:getUserName()
    return self.userName
end
function Buddy:setUserName(_userName)
    self.userName = _userName  
end
function Buddy:getMessageId()
    return self.messageId
end
function Buddy:setMessageId(_messageId)
    self.messageId = _messageId  
end
function Buddy:getBuddyName()
    return self.buddyName
end
function Buddy:setBuddyName(_buddyName)
    self.buddyName = _buddyName  
end
function Buddy:getGroupName()
    return self.groupName
end
function Buddy:setGroupName(_groupName)
    self.groupName = _groupName  
end
function Buddy:getSendedOn()
    return self.sendedOn
end
function Buddy:setSendedOn(_sendedOn)
    self.sendedOn = _sendedOn  
end
function Buddy:getPointList()
    return self.pointList
end
function Buddy:setPointList(_pointList)
    self.pointList = _pointList  
end
function Buddy:getOwnerName()
    return self.ownerName
end
function Buddy:setOwnerName(_ownerName)
    self.ownerName = _ownerName  
end
function Buddy:getStrResponse()
    return self.json
end
function Buddy:setStrResponse(_json)
    self.json = _json  
end
function Buddy:getMessage()
    return self.message
end
function Buddy:setMessage(_message)
    self.message = _message  
end
function Buddy:setResponseSuccess(_success)
    self.success = _success  
end
function Buddy:getResponseSuccess()
    return self.success  
end
function Buddy:getAcceptedOn()
    return self.acceptedOn
end
function Buddy:setAcceptedOn(_acceptedOn)
    self.acceptedOn = _acceptedOn  
end
return Buddy