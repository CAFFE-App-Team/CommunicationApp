--author Himanshu Sharma
local Game = {}
local scoreList = {}
local json = ""
local name = ""
local description = ""
local success = false
local totalRecords
function Game:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Game:getName()
    return self.name
end
function Game:setName(_name)
    self.name = _name  
end
function Game:getDescription()
    return self.description;
end
function Game:setDescription(_description)
    self.description = _description  
end
function Game:getScoreList()
    return self.scoreList
end
function Game:setScoreList(_scoreList)
    self.scoreList = _scoreList  
end
function Game:getStrResponse()
    return self.json
end
function Game:setStrResponse(_json)
    self.json = _json  
end
function Game:setResponseSuccess(_success)
    self.success = _success  
end
function Game:getResponseSuccess()
    return self.success  
end
function Game:getTotalRecords()
    return self.totalRecords
end
function Game:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end
return Game