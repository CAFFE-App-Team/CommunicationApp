--author Himanshu Sharma
local App42API  = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local App42Config  = require("App42-Lua-API.App42Config")
local Util = require("App42-Lua-API.Util")
local JSON  = require("App42-Lua-API.JSON")
local App42Service = {}
local version  = "1.0"
local sessionId =nil
local adminKey  = nil
local secretKey = nil
local orderByDescending = nil 
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local otherMetaHeaders  = {}
local sessionInvalidate = false;
local event = ""
local selectKeys = {}
local defaultACL  = nil
local aclList  = nil
local geoTag = nil
local fbAccessToken = nil
local dbName = ""
local collectionName = ""
local query = ""
local jsonObject={}

function App42Service:setQuery( _collectionName,  metaInfoQuery)
  dbName = App42API:getDbName()
  collectionName = _collectionName
  if (metaInfoQuery) then
  query = Util:queryLength(metaInfoQuery)
else 
  query = nil
  end
end 
function App42Service:addJSONObject( _collectionName, _obj)
    dbName = App42API:getDbName()
		collectionName = _collectionName
		jsonObject = _obj
end
function App42Service:getAdminKey()
  return adminKey
end		
function App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function App42Service:getSessionId()
  return sessionId
end		
function App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function App42Service:getEvent()
  return event
end		
function App42Service:setEvent(_event)
  event = _event
end		
function App42Service:getGeoTag()
  return geoTag
end		
function App42Service:setGeoTag(_geoTag)
  local __geoTag = {}
  if _geoTag:getLat() ~= nil or _geoTag:getLng() ~= nil then
    __geoTag.lat = _geoTag:getLat()
    __geoTag.lng = _geoTag:getLng()
    geoTag  = __geoTag
  end
end
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function App42Service:getOrderByAscending()
  return orderByAscending
end		
function App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function App42Service:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders = _otherMetaHeaders
end		
function App42Service:getSelectKeys()
	return selectKeys
end		
function App42Service:setSelectKeys(_selectKeys)
	selectKeys = _selectKeys
end		
function App42Service:getPageMaxRecords()
  return pageMaxRecords
end		
function App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function App42Service:getPageOffset()
  return pageOffset
end		
function App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end		
function App42Service:getFbAccessToken()
  return fbAccessToken
end		
function App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken = _fbAccessToken
end		
function App42Service:getAclList()
  return aclList
end		
function App42Service:setAclList(_aclList)
  local acl = Util:buildAclRequest(_aclList)
  aclList  = acl
end	
function App42Service:populateSignParams()
local signParams = {}
  signParams.apiKey = App42API:getApiKey()
  signParams.version = version
  signParams.timeStamp = Util:getUTCFormattedTimestamp()
  if sessionId ~= nil and sessionId ~= "" then
    signParams.sessionId = sessionId
  end
  if adminKey ~= nil and adminKey ~= "" then
    signParams.adminKey = adminKey
  end
  if fbAccessToken ~= nil and fbAccessToken ~= "" then
    signParams.fbAccessToken = fbAccessToken
  end
  return signParams
end   
function App42Service:populateMetaHeaderParams()
  local metaHeadersParams = {}
  if pageOffset ~= -1 then
    metaHeadersParams.pageOffset = pageOffset
  end
  if pageMaxRecords ~= -1 then
    metaHeadersParams.pageMaxRecords = pageMaxRecords
  end
  App42Service:setACLHeader(metaHeadersParams)
  if event ~= nil and event ~= "" then
    metaHeadersParams.event = event
  end
  if geoTag ~= nil then
    metaHeadersParams.geoTag = JSON:encode(geoTag)
  end
  if jsonObject ~= nil and jsonObject ~="" then
    metaHeadersParams.jsonObject= JSON:encode(jsonObject)
	end
  if dbName ~=nil and dbName ~="" and collectionName ~=nil and collectionName ~="" then 
    local obj = {}
      obj.dbName = dbName;
      obj.collectionName = collectionName;
      metaHeadersParams.dbCredentials = JSON:encode(obj)
    end
  if query ~=nil and query ~="" then
      metaHeadersParams.metaQuery = query
   end
  local selectJSONKeys = {}
  if selectKeys ~= nil then
    local selectKeysValue = ""
    for keys, value in sortKeyByValue(selectKeys) do
       selectJSONKeys[value] = 1
     end
    metaHeadersParams.selectKeys = JSON:encode(selectJSONKeys)
  end
    metaHeadersParams.SDKName = "Corona"
  if App42API:getLoggedInUser() ~= nil and App42API:getLoggedInUser() ~= "" then
    metaHeadersParams.loggedInUser = App42API:getLoggedInUser()
  end
-- Add Other meta headers if available
  if otherMetaHeaders ~= nil and otherMetaHeaders ~= "" then
   for otherMetaHeadersKey, otherMetaHeadersValue in sortKeyByValue(otherMetaHeaders) do
       metaHeadersParams[otherMetaHeadersKey] = otherMetaHeadersValue
     end
  end
  return metaHeadersParams
end   
function App42Service:setACLHeader(_aclHeader)
  if aclList ~= nil then 
    _aclHeader.dataACL = aclList
  elseif App42API:getDefaultACL() ~= nil then
    _aclHeader.dataACL = App42API:getDefaultACL()
  end
end
function App42Service:populateHeaders(headersParams)
  local headerParam = {}
  headerParam["Content-Type"] = App42Config:getContentType()
  headerParam.Accept = App42Config:getAccept()
  headerParam.SDKName = "lua"
   for headersKey, headersValue in sortKeyByValue(headersParams) do
       headerParam[headersKey] = headersValue
       App42Log:debug("Header Key is : "..headersKey.."   Header Value is : "..JSON:encode(headersValue))
    end
  return headerParam
end   
function App42Service:merge(signParams,headerParams)
  local headers = {}
   for signKey, signValue in sortKeyByValue(signParams) do
       headers[signKey] = signValue
    end
    for headerKey, headerValue in sortKeyByValue(headerParams) do
       headers[headerKey] = headerValue      
    end
  return headers
end  
return App42Service