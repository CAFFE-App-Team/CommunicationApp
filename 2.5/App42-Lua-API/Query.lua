--author Himanshu Sharma
local JSON = require("App42-Lua-API.JSON")
local Query = {}
local jsonArray = {}
local jsonObject = {}

function Query:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Query:query(_jsonObject,_jsonArray)
  local querObject = Query:new()
  if jsonObject == nil then 
    self.jsonArray  = _jsonArray
  else
    self.jsonObject  = _jsonObject
  end
end

function Query:getStr()
  if jsonObject == nil then 
    return self.jsonArray
  else 
    return self.jsonObject
  end
end
return Query