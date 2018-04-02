local Configuration ={}
local emailId, host, port
local ssl = false

function Configuration:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Configuration:getEmailId() 
			return self.emailId;
end 

function Configuration:setEmailId(_emailId) 
			self.emailId = _emailId;
end
function Configuration:getHost()
			return self.host;
end
function Configuration:setHost(_host) 
  self.host = _host;
end
function Configuration:getPort() 
	return self.port;
end
function Configuration:setPort(_port)
	self.port = _port;
end
function Configuration:getSsl() 
	return self.ssl;
end
function Configuration:setSsl(_ssl) 
	self.ssl = _ssl;
end
return Configuration