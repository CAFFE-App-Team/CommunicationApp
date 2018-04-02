local Attribute = {}
local name=""
local value = ""

function Attribute:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Attribute:getName()
    return self.name
end
function Attribute:setName(_name)
  self.name = _name
end

function Attribute:getValue()
    return self.value
end
function Attribute:setValue(_value)
  self.value = _value
end
return Attribute