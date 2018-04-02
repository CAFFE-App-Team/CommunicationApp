--author Himanshu Sharma
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local Reward = require("App42-Lua-API.Reward")
local JSON = require("App42-Lua-API.JSON")
local RewardResponseBuilder = {}

function RewardResponseBuilder:buildResponse(json)
  local reward = require("App42-Lua-API.Reward")
  local rewardsJSONObj = App42ResponseBuilder:getServiceJSONObject("rewards",json)
    if(rewardsJSONObj == nil) then 
      reward:setStrResponse(json)
      reward:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
      reward:setTotalRecords(App42ResponseBuilder:getTotalRecords(json))
    else 
      local rewardJSONObject = rewardsJSONObj.reward
      reward =  RewardResponseBuilder:buildRewardObject(rewardJSONObject)
      reward:setStrResponse(json)
      reward:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    end
  return reward
end
-----
function RewardResponseBuilder:buildArrayResponse(responseString)
  local reward = require("App42-Lua-API.Reward")
  local rewardJSONArray = {}
  local rewardsJSONObj = App42ResponseBuilder:getServiceJSONObject("rewards",responseString)
  local rewardJSONObjectArray = rewardsJSONObj.reward
  if table.getn(rewardJSONObjectArray) > 0 then
    for i=1, table.getn(rewardJSONObjectArray) do
      reward = RewardResponseBuilder:buildRewardObject(rewardJSONObjectArray[i])
      reward:setStrResponse(responseString)
      reward:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
      rewardJSONArray[i] = reward
    end    
  else
    reward = RewardResponseBuilder:buildRewardObject(rewardJSONObjectArray)
    reward:setStrResponse(responseString)
    reward:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
    rewardJSONArray = reward
  end
  return rewardJSONArray
end
function RewardResponseBuilder:buildRewardObject(rewardJSONObject)
  local reward = RewardResponseBuilder:buildObjectFromJSONTree(rewardJSONObject)
  return reward
end
function RewardResponseBuilder:buildObjectFromJSONTree(json)
  local reward = Reward:new()
  if(json.name ~= nil)then
    reward:setName(json.name)
  end
  if(json.description ~= nil) then
    reward:setDescription(json.description)
  end
  if(json.points ~= nil) then
    reward:setPoints(json.points)
  end
  if(json.gameName ~= nil) then
    reward:setGameName(json.gameName)
  end
  if(json.userName ~= nil) then
    reward:setUserName(json.userName)
  end
  if(json.rank ~= nil) then
    reward:setRank(json.rank)
  end
  return reward
end
return RewardResponseBuilder