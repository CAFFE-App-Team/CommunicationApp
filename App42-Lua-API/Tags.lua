--author Himanshu Sharma
local Tags = {}
local user= nil
local tagName= nil
local taggedOn= nil

function Tags:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Tags:getUser() 
			return self.user;
end

function Tags:setUser(_user) 
			self.user = _user;
end

function Tags:getTagName() 
	return self.tagName;
end

function Tags:setTagName(_tagName) 
  self.tagName = _tagName;
end

function Tags:getTaggedOn() 
  return self.taggedOn;
end

function Tags:setTaggedOn(_taggedOn) 
  self.taggedOn = _taggedOn;
end
return Tags