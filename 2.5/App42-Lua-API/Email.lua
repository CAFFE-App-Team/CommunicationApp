local Email = {}
local from;
local to;
local subject;
local body;
local json
local success= false
local configList = require("App42-Lua-API.Configuration")
function Email:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Email:getFrom()
		return self.from;
end
function Email:setFrom(_from) 
		self.from = _from;
end
function Email:getTo()
		return self.to;
end
function Email:setTo(_to)
		self.to = _to;
end
function Email:getSubject()
		return self.subject;
end
function Email:setSubject(_subject)
		self.subject = _subject;
end
function Email:getBody()
		return self.body;
end
function Email:setBody(_body)
		self.body = _body;
end
function Email:getConfigList()
	return self.configList;
end
function Email:setConfigList(_configList)
	self.configList = _configList;
end
function Email:setResponseSuccess(_success)
   self.success = _success  
end
function Email:getResponseSuccess()
  return self.success  
end
function Email:getStrResponse()
  return self.json
end
function Email:setStrResponse(_json)
  self.json = _json  
end
return Email