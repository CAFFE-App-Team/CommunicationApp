local ACL = {}
local user  = ""
local permission = ""

function ACL:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function ACL:getUser()
    return self.user
end
function ACL:setUser(_user)
    self.user = _user  
end
function ACL:getPermission()
    return self.permission
end
function ACL:setPermission(_permission)
    self.permission = _permission  
end
return ACL
