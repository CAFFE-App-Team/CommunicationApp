local File = {}
local name= nil
local userName= nil
--local type = nil
local url= nil
local tinyUrl= nil
local description= nil

function File:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function File:getName()
		return self.name;
end

function File:setName(_name) 
			self.name = _name;
end
function File:getUserName() 
  	return self.userName;
end
	

function File:setUserName(_userName) 
	self.userName = _userName;
end


function File:getType() 
	return self.type;
end
	

function File:setType(_type) 
  self.type = _type;
end    


function File:getUrl() 
  return self.url;
end  

function File:setUrl(_url)
			self.url = _url;
end

function File:getTinyUrl() 
   return self.tinyUrl;
end   

function File:setTinyUrl(_tinyUrl) 
	self.tinyUrl = _tinyUrl;
end
function File:getDescription() 
	return self.description;
end

function File:setDescription(_description) 
	self.description = _description;
end
return File