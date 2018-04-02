--author Himanshu Sharma
local Reward = {}
local rank = nil
local name = nil
local json = nil
local points
local userName = nil
local gameName = nil
local success = false
local description = nil
local totalRecords

function Reward:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Reward:getUserName()
    return self.userName
end
function Reward:setUserName(_userName)
    self.userName = _userName  
end
function Reward:getName()
    return self.name
end
function Reward:setName(_name)
    self.name = _name  
end
function Reward:getGameName()
    return self.gameName
end
function Reward:setGameName(_gameName)
    self.gameName = _gameName  
end
function Reward:getDescription()
    return self.description
end
function Reward:setDescription(_description)
    self.description = _description  
end
function Reward:getRank()
    return self.rank
end
function Reward:setRank(_rank)
    self.rank = _rank  
end
function Reward:getPoints()
    return self.points
end
function Reward:setPoints(_points)
    self.points = _points  
end
function Reward:getTotalRecords()
    return self.totalRecords
end
function Reward:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end
function Reward:getStrResponse()
    return self.json
end
function Reward:setStrResponse(_json)
    self.json = _json  
end
function Reward:setResponseSuccess(_success)
    self.success = _success  
end
function Reward:getResponseSuccess()
    return self.success  
end
return Reward