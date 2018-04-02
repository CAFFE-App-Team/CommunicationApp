local Friends = {}
local name
local picture
local id
local installed
    function Friends:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Friends:getInstalled()
    return self.installed
end
function Friends:setInstalled(_installed)
    self.installed = _installed
end

function Friends:getName()
    return self.name
end
function Friends:setName(_name)
    self.name = _name
end

function Friends:getPicture()
    return self.picture
end
function Friends:setPicture(_picture)
    self.picture = _picture
end
function Friends:getId()
    return self.id
end
function Friends:setId(_id)
    self.id = _id
end
return Friends