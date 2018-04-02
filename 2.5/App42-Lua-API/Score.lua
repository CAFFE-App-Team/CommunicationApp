--author Himanshu Sharma
local Score = {}
local createdOn = nil
local scoreId = nil
local userName = nil
local facebookArrayList = require("App42-Lua-API.FacebookProfile")
local jsonDocList = require("App42-Lua-API.JSONDocument")
local value

function Score:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Score:getFacebookProfile()
    return self.facebookArrayList
end
function Score:setFacebookProfile(_facebookArrayList)
    self.facebookArrayList = _facebookArrayList  
end
function Score:getCreatedOn()
    return self.createdOn
end
function Score:setCreatedOn(_createdOn)
    self.createdOn = _createdOn  
end
function Score:getScoreId()
    return self.scoreId
end
function Score:setScoreId(_scoreId)
    self.scoreId = _scoreId  
end
function Score:getUserName()
    return self.userName
end
function Score:setUserName(_userName)
    self.userName = _userName  
end
function Score:getValue()
    return self.value
end
function Score:setValue(_value)
    self.value = _value  
end
function Score:getJsonDocList()
    return self.jsonDocList
end
function Score:setJsonDocList(_jsonDocList)
  self.jsonDocList = _jsonDocList
end
return Score