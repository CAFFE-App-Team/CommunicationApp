--author Himanshu Sharma
local PublicProfile = {}
local name = nil
local picture = nil
local id= nil

function PublicProfile:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function PublicProfile:getName()
    return name
end
function PublicProfile:setName(_name)
    name = _name  
end
function PublicProfile:getPicture()
    return picture
end
function PublicProfile:setPicture(_picture)
    picture = _picture  
end
function PublicProfile:getId()
    return id
end
function PublicProfile:setId(_id)
    id = _id  
end
return PublicProfile