local Timer = {}
local json = ""
local name= nil
local currentTime;
local timeInSeconds;
local startTime;
local endTime;
local userName= nil
local isTimerActive= true
local success= false

function Timer:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function Timer:getUserName() 
  return self.userName;
end
function Timer:setUserName(_userName) 
    self.userName = _userName;
end
function Timer:getName() 
		return self.name;
end
function Timer:setName(_name) 
		self.name = _name;
end
function Timer:getCurrentTime() 
		return self.currentTime;
end
function Timer:setCurrentTime(_currentTime) 
		self.currentTime = _currentTime;
end
function Timer:getTimeInSeconds() 
		return self.timeInSeconds;
end
function Timer:setTimeInSeconds(_timeInSeconds) 
		self.timeInSeconds = _timeInSeconds;
end
function Timer:getStartTime() 
		return self.startTime;
end
function Timer: setStartTime(_startTime) 
		self.startTime = _startTime;
end
function Timer:getEndTime() 
		return self.endTime;
end
function Timer:setEndTime(_endTime) 
		self.endTime = _endTime;
end
function Timer:getIsTimerActive() 
		return self.isTimerActive;
end
function Timer:setIsTimerActive(_isTimerActive) 
		self.isTimerActive = _isTimerActive;
end
function Timer:setResponseSuccess(_success)
    self.success = _success  
end
function Timer:getResponseSuccess()
    return self.success  
end
function Timer:getStrResponse()
    return self.json
end
function Timer:setStrResponse(_json)
    self.json = _json  
end
return Timer