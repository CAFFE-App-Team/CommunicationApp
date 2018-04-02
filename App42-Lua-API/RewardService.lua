--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local resource = "game/reward"
local version = "1.0"  
local RewardService =  {}
local queryParams =  {}  
local orderByDescending =  nil 
local orderByAscending =  nil
local pageOffset = -1
local pageMaxRecords = -1
local aclList =  nil
local adminKey =  nil
local fbAccessToken = nil
local sessionId =  nil
local selectKeys =  {}
local otherMetaHeaders =  {} 
--Creates reward can be Sword, Energy etc. When Reward Points have to be added the 
--Reward name created using this method has to be specified.
--rewardName  - The reward that has to be created
--description - The description of the reward to be created
--callback - Callback object for success/exception result
function RewardService:createReward(rewardName,description,callBack)
   if rewardName == nil or rewardName == "" or Util:trim(rewardName) == "" or description == nil or description == "" or Util:trim(description) == "" then
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
      Util:throwExceptionIfNullOrBlank(description,"Description", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)  
    local rewardJson = {}
    local app42 =  {}    
    local rewards =  {}   
    local reward =  {}  
    rewardJson.name = rewardName    
    rewardJson.description = description
    reward.reward = rewardJson
    rewards.rewards = reward
    app42.app42 = rewards
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
--Fetches all the Rewards
--callback - Callback object for success/exception result
function RewardService:getAllRewards(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.isArray = "true"
  headerParams.resource = resource
  local resourceURL = version.."/"..resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
--Fetches the count of all the Rewards  
--callback - Callback object for success/exception result
function RewardService:getAllRewardsCount(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource .."/count"
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
--Fetches all the Rewards by paging.
--max - Maximum number of records to be fetched
--offset - From where the records are to be fetched  
--callback - Callback object for success/exception result
function RewardService:getAllRewardsWithPaging(max,offset,callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)  
  signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.isArray = "true"
  headerParams.resource = resource
  local resourceURL = version.."/"..resource .."/paging".."/"..max.."/"..offset
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
--Retrieves the reward for the specified name
--rewardName - Name of the reward that has to be fetched
--callback - Callback object for success/exception result
function RewardService:getRewardByName(rewardName,callBack)
  if rewardName == nil or rewardName == "" or Util:trim(rewardName) == "" then
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)  
    signParams.name = rewardName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"..rewardName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Adds the reward points to an users account. Reward Points can be earned by the user which can be redeemed later.
--gameName - Name of the game for which reward points have to be added
--userName - The user for whom reward points have to be added
--rewardName - The rewards for which reward points have to be added
--rewardPoints - The points that have to be added
--callback - Callback object for success/exception result
function RewardService:earnRewards(gameName,userName,rewardName,rewardPoints,callBack)
  if gameName == nil or gameName == "" or Util:trim(gameName) == "" or userName == nil or userName == "" 
    or Util:trim(userName) == "" or rewardName == nil or rewardName == "" or Util:trim(rewardName)=="" then
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)  
    local rewardJson = {}
    local app42 =  {}    
    local rewards =  {}   
    local reward =  {}  
    rewardJson.name = rewardName    
    rewardJson.gameName = gameName
    rewardJson.userName = userName
    rewardJson.points = rewardPoints
    reward.reward = rewardJson
    rewards.rewards = reward
    app42.app42 = rewards
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/earn"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
--Deducts the reward points from the earned rewards by a User:
--gameName - Name of the game for which reward points have to be deducted
--userName - The user for whom reward points have to be deducted
--rewardName - The rewards for which reward points have to be deducted
--rewardPoints - The points that have to be deducted
--callback - Callback object for success/exception result
function RewardService:redeemRewards(gameName,userName,rewardName,rewardPoints,callBack)
  if gameName == nil or gameName == "" or Util:trim(gameName) == "" or userName == nil or userName == "" 
    or Util:trim(userName) == "" or rewardName == nil or rewardName == "" or Util:trim(rewardName)=="" then
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)  
    local rewardJson = {}
    local app42 =  {}    
    local rewards =  {}   
    local reward =  {}  
    rewardJson.name = rewardName    
    rewardJson.gameName = gameName
    rewardJson.userName = userName
    rewardJson.points = rewardPoints
    reward.reward = rewardJson
    rewards.rewards = reward
    app42.app42 = rewards
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/redeem"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
--Fetches the reward points for a particular user
--gameName - Name of the game for which reward points have to be fetched
--userName - The user for whom reward points have to be fetched
--callback - Callback object for success/exception result
function RewardService:getGameRewardPointsForUser(gameName,userName,callBack)
  if gameName == nil or gameName == "" or Util:trim(gameName) == "" or 
    userName == nil or userName == "" or Util:trim(userName) == "" then
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)  
    signParams.gameName = gameName  
    signParams.userName = userName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.isArray = "true"
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"..gameName.."/"..userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function provides a list of specified number of top reward earners for a specific Game:
--gameName - Name of the game for which reward earners are to be fetched
--rewardName - Name of the reward for which list of earners is to be fetched
--max - Specifies the number of top earners to be fetched
--callback - Callback object for success/exception result
function RewardService:getTopNRewardEarners(gameName,rewardName,max,callBack)
  if gameName == nil or gameName == "" or Util:trim(gameName) == "" or 
    rewardName == nil or rewardName == "" or Util:trim(rewardName) == "" then
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)  
    signParams.gameName = gameName  
    signParams.rewardName = rewardName
    signParams.max = max
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.isArray = "true"
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"..gameName.."/"..rewardName.."/"..max
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns you the details of all the specific rewards earned by the specified User:
--userName - Name of the user whose rewards are to be fetched
--rewardName - Name of the reward for which details are to be fetched
--callback - Callback object for success/exception result
function RewardService:getAllRewardsByUser(userName,rewardName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" or 
    rewardName == nil or rewardName == "" or Util:trim(rewardName) == "" then
      Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)  
    signParams.userName = userName  
    signParams.rewardName = rewardName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.isArray = "true"
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"..userName.."/points/"..rewardName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Fetches the reward rank for a particular user
--gameName - Name of the game for which user rank have to be fetched
--rewardName - Name of the reward for which user rank have to be fetched
--userName - Name of the user for which rank have to be fetched
--callback - Callback object for success/exception result
function RewardService:getUserRankingOnReward(gameName,rewardName,userName,callBack)
  if gameName == nil or gameName == "" or Util:trim(gameName) == "" or userName == nil or userName == "" or 
    Util:trim(userName) == "" or rewardName == nil or rewardName == "" or Util:trim(rewardName) == "" then
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)  
    signParams.gameName = gameName   
    signParams.userName = userName  
    signParams.rewardName = rewardName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource.."/"..gameName.."/"..rewardName.."/".."rank".."/"..userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns you a list of group wise users who earned the top rewards in the specified game .
--gameName - Name of the game for which top reward earners are to be fetched
--rewardName - Name of the reward for which top earners are to be listed
--userList - List of group wise users earning specified rewards
--callback - Callback object for success/exception result
function RewardService:getTopNRewardEarnersByGroup(gameName,rewardName,userList,callBack)
  if gameName == nil or gameName == "" or Util:trim(gameName) == "" or rewardName == nil or rewardName == "" 
    or Util:trim(rewardName) == "" then
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
      Util:throwExceptionIfNullOrBlank(rewardName,"RewardName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)  
    signParams.gameName = gameName   
    signParams.userList = JSON:encode(userList)  
    signParams.rewardName = rewardName
    queryParams.userList = JSON:encode(userList) 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.isArray = "true"
    headerParams.resource = resource
    local resourceURL = version.."/"..resource.."/"..gameName.."/"..rewardName.."/".."group/points"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
function RewardService:getFbAccessToken()
  return fbAccessToken
end		
function RewardService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function RewardService:getSessionId()
  return sessionId
end		
function RewardService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function RewardService:getAdminKey()
  return adminKey
end		
function RewardService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function RewardService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function RewardService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function RewardService:getSelectKeys()
  return selectKeys
end		
function RewardService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function RewardService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function RewardService:getOrderByAscending()
  return orderByAscending
end		
function RewardService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function RewardService:getAclList()
  return aclList
end		
function RewardService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function RewardService:getPageMaxRecords()
  return pageMaxRecords
end		
function RewardService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function RewardService:getPageOffset()
  return pageOffset
end		
function RewardService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end
end
return RewardService