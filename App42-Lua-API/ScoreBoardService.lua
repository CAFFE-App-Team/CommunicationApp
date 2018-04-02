--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local resource = "game/scoreboard"
local version = "1.0"
local orderByDescending = nil 
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local aclList = {}
local adminKey = nil
local fbAccessToken = nil
local sessionId = nil
local selectKeys = {}
local otherMetaHeaders = {}
local ScoreBoardService = {}
--Saves the User score for a game in async mode.
--gameName - Name of the game for which score has to be saved
--userName - The user for which score has to be saved
--gameScore - The sore that has to be saved
--callback - Callback object for success/exception result
function ScoreBoardService:saveUserScore(gameName,userName,gameScore,callBack)
  if userName==nil or userName=="" or Util:trim(userName)=="" or gameName==nil or gameName=="" or Util:trim(gameName)=="" then
      Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
      Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack) 
  else
      local queryParams= {}
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)      
      local scoresJson = {}
      local scoreJson = {}
      local gameJson = {}
      local app42 = {}    
      local game = {}
      scoreJson.userName = userName
      scoreJson.value = gameScore
      scoresJson.score = scoreJson
      gameJson.name = gameName 
      gameJson.scores = scoresJson
      game.game = gameJson
      app42.app42 = game
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
--Retrieves the scores for a game for the specified name
--gameName - Name of the game for which score has to be fetched
--userName - The user for which score has to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getScoresByUser(gameName,userName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or userName==nil or userName=="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/"..userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Retrieves the lowest game score for the specified user in async mode.
--gameName - Name of the game for which lowest score has to be fetched
--userName - The user for which lowest score has to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getLowestScoreByUser(gameName,userName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or userName==nil or userName=="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/"..userName.."/lowest"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Retrieves the average game score for the specified user in async mode.
--gameName - Name of the game for which average score has to be fetched
--userName - The user for which average score has to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getAverageScoreByUser(gameName,userName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or userName==nil or userName=="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/"..userName.."/average"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Retrieves the highest game score for the specified user in async mode.
--gameName - Name of the game for which highest score has to be fetched
--userName - The user for which highest score has to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getHighestScoreByUser(gameName,userName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or userName==nil or userName=="" or Util:trim(userName)=="" then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/"..userName.."/highest"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Retrieves the Top Rankings for the specified game in async mode.
--gameName - Name of the game for which ranks have to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getTopRankings(gameName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/ranking"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Retrieves the Top N Rankings for the specified game in async mode.
--gameName - Name of the game for which ranks have to be fetched
--max - Maximum number of records to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getTopNRankings(gameName,max,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.max = max    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/ranking".."/"..max
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns the specified number of top rankers in a specific game in async mode.
--gameName - Name of the game
--max - Maximum number of records to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getTopNRankers(gameName,max,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.max = max    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/rankers".."/"..max
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Retrieves the User Ranking for the specified game in async mode.
--gameName- Name of the game for which ranks have to be fetched
--userName - Name of the user for which ranks have to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getUserRanking(gameName,userName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or userName==nil or userName=="" or Util:trim(userName)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/" .. userName.."/ranking"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns the top score attained by the specified user in the game
--gameName - Name of the game
--userName - Name of the user for which score has to retrieve
--callback - Callback object for success/exception result
function ScoreBoardService:getLastScoreByUser(gameName,userName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or userName==nil or userName=="" or Util:trim(userName)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/" .. userName.."/lastscore"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns the score attained by the specified user in the last game session.
--userName - Name of the for which score has to retrieve.
--callback - Callback object for success/exception result
function ScoreBoardService:getLastGameScore(userName,callBack)
  if userName==nil or userName=="" or Util:trim(userName)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userName = userName    
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. userName.."/lastgame"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns the top ranking based on user score
--gameName - Name of the game
--userList - List of the user for which ranking has to retrieve
--callback - Callback object for success/exception result
function ScoreBoardService:getTopRankingsByGroup(gameName,userList,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
      local queryParams ={}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userList = JSON:encode(userList)  
    queryParams = signParams
    signParams.userList = JSON:encode(userList)  
    signParams.name = gameName    
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/group"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--This function returns the top ranking based on user score
--gameName - Name of the game
--userList - List of the user for which ranking has to retrieve
--callback - Callback object for success/exception result
function ScoreBoardService:getTopNRankersByGroup(gameName,userList,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams ={}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.userList = JSON:encode(userList)  
    queryParams = signParams
    signParams.userList = JSON:encode(userList)  
    signParams.name = gameName    
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" .. gameName.."/rankers/group"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Edit the game score by score id of the user in async mode.
--scoreId - Id for which score has to be edit
--gameScore - The game score that has to be edit
--callback - Callback object for success/exception result
function ScoreBoardService:editScoreValueById(scoreId,gameScore,callBack)
  if scoreId==nil or scoreId=="" or Util:trim(scoreId)==""  then
      Util:throwExceptionIfNullOrBlank(scoreId,"ScoreId", callBack) 
  else
      local queryParams= {}
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)    
      local scoresJson = {}
      local scoreJson = {}
      local gameJson = {}
      local app42 = {}    
      local game = {}
      scoreJson.scoreId = scoreId
      scoreJson.value = gameScore
      scoresJson.score = scoreJson
      gameJson.scores = scoresJson
      game.game = gameJson
      app42.app42 = game
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.."/editscore"
      RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack) 
  end
end
--This method helps to fetch the top N rankers from your facebook friends.
--gameName - Game name for which top N rankers has to fetch.
--fbAccessToken- Fackebook access token of the user who is fetching the record.
--max - Max number of rankers to be fetched
--callback - Callback object for success/exception result
function ScoreBoardService:getTopNRankersFromFacebook(gameName,fbAccessToken,max,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" or fbAccessToken==nil or fbAccessToken==""
    or Util:trim(fbAccessToken)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
    Util:throwExceptionIfNullOrBlank(fbAccessToken,"FB AccessToken", callBack)
  else
    local queryParams= {}
    ScoreBoardService:setFbAccessToken(fbAccessToken)
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.max = max    
    signParams.name = gameName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"..gameName.."/rankers/facebook/"..max
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
function ScoreBoardService:getTopNTargetRankers(gameName,max,callBack)
if gameName==nil or gameName=="" or Util:trim(gameName)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.name = gameName 
    signParams.max = max 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
      local resourceURL = version.."/"..resource .."/"..gameName.."/targetedrankers/"..max
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
 end
end

function ScoreBoardService:getUsersWithScoreRange(gameName,minScore,maxScore,callBack)
if gameName==nil or gameName=="" or Util:trim(gameName)==""  then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local queryParams= {}
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.name = gameName 
    signParams.minScore = minScore 
    signParams.maxScore = maxScore 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"..gameName.."/range/"..minScore.."/"..maxScore
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
 end
end

function ScoreBoardService:getFbAccessToken()
  return fbAccessToken
end		
function ScoreBoardService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function ScoreBoardService:getSessionId()
  return sessionId
end		
function ScoreBoardService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function ScoreBoardService:getAdminKey()
  return adminKey
end		
function ScoreBoardService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function ScoreBoardService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function ScoreBoardService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function ScoreBoardService:getSelectKeys()
  return selectKeys
end		
function ScoreBoardService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function ScoreBoardService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function ScoreBoardService:getOrderByAscending()
  return orderByAscending
end		
function ScoreBoardService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function ScoreBoardService:getAclList()
  return aclList
end		
function ScoreBoardService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function ScoreBoardService:getPageMaxRecords()
  return pageMaxRecords
end		
function ScoreBoardService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function ScoreBoardService:getPageOffset()
  return pageOffset
end		
function ScoreBoardService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end		
function ScoreBoardService:setQuery(_collectionName,  metaInfoQuery)
  App42Service:setQuery(_collectionName,  metaInfoQuery)
end
function ScoreBoardService:addJSONObject(_collectionName, _obj)
    App42Service:addJSONObject( _collectionName, _obj)
end
return ScoreBoardService