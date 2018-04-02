local TimerResponseBuilder ={}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local Timer = require("App42-Lua-API.Timer")
function TimerResponseBuilder:buildResponse(json)
    local timer =Timer:new()
    local timerJSONObj = App42ResponseBuilder:getServiceJSONObject("timer",json)
    if timerJSONObj == nil then 
      timer:setStrResponse(json)
      timer:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    else    
      
      timer = TimerResponseBuilder:buildTimerObject(timerJSONObj)
      timer:setStrResponse(json)
      timer:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))  
    end
  return timer
end
function TimerResponseBuilder:buildTimerObject(timerJSONObj)
  local timer = TimerResponseBuilder:buildObjectFromJSONTree(timerJSONObj);
return timer;
end

function TimerResponseBuilder:buildObjectFromJSONTree(json)
  local timer =Timer:new()
  if(json.userName ~= nil)then
    timer:setUserName(json.userName)
  end
  if(json.name ~= nil) then
    timer:setName(json.name)
  end
  if(json.currentTime ~= nil) then
    timer:setCurrentTime(json.currentTime)
    end
  if(json.timeInSeconds ~= nil) then
    timer:setTimeInSeconds(json.timeInSeconds)
    end
  if(json.startTime ~= nil) then
    timer:setStartTime(json.startTime)
  end
   if(json.endTime ~= nil) then
    timer:setEndTime(json.endTime)
  end
   if(json.isTimerActive ~= nil) then
    timer:setIsTimerActive(json.isTimerActive)
  end
  print("vfjdghjngjjhlk")
  local JSON = require("App42-Lua-API.JSON") 
  print(JSON:encode(timer))
  return timer
end
return TimerResponseBuilder