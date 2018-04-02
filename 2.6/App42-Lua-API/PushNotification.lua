--author Himanshu Sharma
local PushNotification = {}
local channelList = require("App42-Lua-API.Channel")
local deviceToken = nil
local message = nil
local userName = nil
local json = nil
local expiry
local deviceType = nil
local success = false
local state=nil
function PushNotification:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function PushNotification:getType()
    return self.type
end
function PushNotification:setType(_type)
    self.type = _type  
end
function PushNotification:getUserName()
    return self.userName
end
function PushNotification:setUserName(_userName)
    self.userName = _userName  
end
function PushNotification:getMessage()
    return self.message
end
function PushNotification:setMessage(_message)
    self.message = _message  
end
function PushNotification:getChannelList()
    return self.channelList
end
function PushNotification:setChannelList(_channelList)
    self.channelList = _channelList  
end
function PushNotification:getDeviceToken()
    return self.deviceToken
end
function PushNotification:setDeviceToken(_deviceToken)
    self.deviceToken = _deviceToken  
end
function PushNotification:getExpiry()
    return self.expiry
end
function PushNotification:setExpiry(_expiry)
    self.expiry = _expiry  
end
function PushNotification:getTotalRecords()
    return self.totalRecords
end
function PushNotification:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end
function PushNotification:getStrResponse()
    return self.json
end
function PushNotification:setStrResponse(_json)
    self.json = _json  
end
function PushNotification:setResponseSuccess(_success)
    self.success = _success  
end
function PushNotification:getResponseSuccess()
    return self.success  
end
function PushNotification:setState(_state)
    self.state = _state  
end
function PushNotification:getState()
    return self.state  
end
return PushNotification