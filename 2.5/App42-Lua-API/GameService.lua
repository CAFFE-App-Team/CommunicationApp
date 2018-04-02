--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local GameService =  {}
local queryParams =   {}
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
local resource = "game"
local version = "1.0"

--Creates a game on the cloud in async mode.
--gameName - Name of the game that has to be created
--description - Description of the game to be created
--callback - Callback object for success/exception result
function GameService:createGame(gameName,description,callBack)
  
  if gameName == nil or gameName== "" or Util:trim(gameName)=="" or description==nil or description=="" or Util:trim(description) == "" then
     Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
    Util:throwExceptionIfNullOrBlank(description,"Description", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local gameJson ={}
    local app42 = {} 
    local game =  {}  
    gameJson.name = gameName    
    gameJson.description = description
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
--Retrieves the game by the specified name in async mode.
--gameName - Name of the game that has to be fetched
--callback - Callback object for success/exception result
function GameService:getGameByName(gameName,callBack)
  if gameName==nil or gameName=="" or Util:trim(gameName)=="" then
    Util:throwExceptionIfNullOrBlank(gameName,"GameName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams= App42Service:merge(signParams,metaHeaderParams)
    signParams.name = gameName
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/" ..gameName;
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Fetches all games for the App in async mode.
--callback - Callback object for success/exception result
function GameService:getAllGames(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource  
  headerParams.isArray = "true"
  local resourceURL = version.."/"..resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
--Fetches the count of all games for the App in async mode.
--callback - Callback object for success/exception result
function GameService:getAllGamesCount(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/count"
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
--Fetches all games for the App by paging in async mode.
--max - Maximum number of records to be fetched
--offset - From where the records are to be fetched
--callback - Callback object for success/exception result
function GameService:getAllGamesWithPaging(max,offset,callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams)
  signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource  
  headerParams.isArray = "true"
  local resourceURL = version.."/"..resource .."/paging".."/"..max.."/"..offset
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
function GameService:getFbAccessToken()
  return fbAccessToken
end		
function GameService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function GameService:getSessionId()
  return sessionId
end		
function GameService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function GameService:getAdminKey()
  return adminKey
end		
function GameService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function GameService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function GameService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function GameService:getSelectKeys()
  return selectKeys
end		
function GameService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function GameService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function GameService:getOrderByAscending()
  return orderByAscending
end		
function GameService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function GameService:getAclList()
  return aclList
end		
function GameService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function GameService:getPageMaxRecords()
  return pageMaxRecords
end		
function GameService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function GameService:getPageOffset()
  return pageOffset
end		
function GameService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end
return GameService