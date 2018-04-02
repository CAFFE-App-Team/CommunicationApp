--author Samita Mahajan
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local GeoService =  {}
local orderByDescending = nil
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local aclList = {}
local adminKey = nil
local fbAccessToken = nil
local sessionId = ""
local selectKeys = {}
local otherMetaHeaders = {}  
local resource = "geo"
local version = "1.0"

function GeoService:createGeoPoints(geoStorageName,geoPointsList,callBack)
  if geoStorageName == nil or geoStorageName == "" or Util:trim(geoStorageName) == ""  then
      Util:throwExceptionIfNullOrBlank(geoStorageName,"Storage Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the geo JSON        
      local geoJson ={}
      local app42 = {}    
      local geo =  {} 
      local storage =  {} 
      local pointsObj= {}
      local point = {}
      pointsObj.point = geoPointsList;
      geoJson.points = pointsObj    
      geoJson.storageName = geoStorageName    
      storage.storage = geoJson
      geo.geo = storage
      app42.app42 = geo
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.. "/createGeoPoints"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
end
end
function GeoService:getNearByPointsByMaxDistance( storageName,  lat,
			 lng,  distanceInKM,callBack)
  if storageName == nil or storageName == "" or Util:trim(storageName) == ""  or  lat == nil or lat == "" or   lng == nil or lng == ""   or  distanceInKM == nil or distanceInKM == ""  then

    Util:throwExceptionIfNullOrBlank(storageName,"StorageName", callBack)
    Util:throwExceptionIfNullOrBlank(lat, "Latitute", callBack)
    Util:throwExceptionIfNullOrBlank(lng, "langitude", callBack)
    Util:throwExceptionIfNullOrBlank(distanceInKM, "Distance In KM", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.storageName = storageName 
    signParams.lat = lat     
    signParams.lng = lng     
    signParams.distanceInKM = distanceInKM          
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/getNearByPoints/storageName/" ..storageName
					.. "/lat/" .. lat.. "/lng/".. lng.. "/distanceInKM/" .. distanceInKM;
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function GeoService:getNearByPoint( storageName,  lat,
			 lng,  resultLimit,callBack)
  if storageName == nil or storageName == "" or Util:trim(storageName) == ""  or  lat == nil or lat == ""  or  lng == nil or lng == ""  or  resultLimit == nil or resultLimit == ""  then
    Util:throwExceptionIfNullOrBlank(storageName,"StorageName", callBack)
    Util:throwExceptionIfNullOrBlank(lat, "Latitute", callBack)
    Util:throwExceptionIfNullOrBlank(lng, "langitude", callBack)
    Util:throwExceptionIfNullOrBlank(resultLimit, "resultLimit", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.storageName = storageName 
    signParams.lat = lat     
    signParams.lng = lng     
    signParams.resultLimit = resultLimit          
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/getNearByPoint/storageName/" ..storageName
					.. "/lat/" .. lat.. "/lng/".. lng.."/limit/".. resultLimit;
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function GeoService:getPointsWithInCircle( storageName,  lat, lng,  radiusInKM,resultLimit,callBack)
if storageName == nil or storageName == "" or Util:trim(storageName) == ""  or  lat == nil or lat == "" 
 or  lng == nil or lng == ""  or  radiusInKM == nil or radiusInKM == ""  or  resultLimit == nil or resultLimit == ""  then
    Util:throwExceptionIfNullOrBlank(storageName,"StorageName", callBack)
    Util:throwExceptionIfNullOrBlank(lat, "Latitute", callBack)
    Util:throwExceptionIfNullOrBlank(lng, "langitude", callBack)
    Util:throwExceptionIfNullOrBlank(radiusInKM, "Radius In KM", callBack)
    Util:throwExceptionIfNullOrBlank(resultLimit, "Result Limit", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.storageName = storageName 
    signParams.lat = lat     
    signParams.lng = lng     
    signParams.resultLimit = resultLimit       
    signParams.radiusInKM = radiusInKM          
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/getPointsWithInCircle/storageName/" ..storageName
					.. "/lat/" .. lat.. "/lng/".. lng.."/radiusInKM/"..radiusInKM.. "/limit/" .. resultLimit
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function GeoService:getAllStorage(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local queryParams =  {} 
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/storage";
  headerParams.isArray = "true"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function GeoService:getAllStorageByPaging(max,offset,callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/paging".."/"..max.."/"..offset
  headerParams.isArray = "true"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function GeoService:deleteStorage(storageName,callBack)
  if storageName == nil or storageName =="" or Util:trim(storageName)=="" then
    Util:throwExceptionIfNullOrBlank(storageName,"StorageName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.storageName = storageName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .. "/storage/" .. storageName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function GeoService:getAllPoints(storageName,callBack)
  if storageName == nil or storageName =="" or Util:trim(storageName)=="" then
    Util:throwExceptionIfNullOrBlank(storageName,"StorageName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local queryParams =  {} 
  signParams.storageName = storageName 
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/points/".. storageName;
  headerParams.isArray = "true"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function GeoService:getAllPointsByPaging(storageName,max,offset,callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  signParams.storageName = storageName 
  signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/paging/points/".. storageName .. "/" .. max .."/" .. offset;
  headerParams.isArray = "true"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function GeoService:createGeoPoints(geoStorageName,geoPointsList,callBack)
  if geoStorageName == nil or geoStorageName == "" or Util:trim(geoStorageName) == ""  then
      Util:throwExceptionIfNullOrBlank(geoStorageName,"Storage Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Creating the geo JSON        
      local geoJson ={}
      local app42 = {}    
      local geo =  {} 
      local storage =  {} 
      local pointsObj= {}
      pointsObj.point = JSON:encode(geoPointsList)  
      geoJson.points = pointsObj    
      geoJson.storageName = geoStorageName    
      storage.storage = geoJson
      geo.geo = storage
      app42.app42 = geo
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.body =  jsonBody
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.. "/createGeoPoints"
      RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack) 
end
end


function GeoService:deleteGeoPoints(geoStorageName,geoPointsList,callBack)
  if geoStorageName == nil or geoStorageName == "" or Util:trim(geoStorageName) == ""  then
      Util:throwExceptionIfNullOrBlank(geoStorageName,"Storage Name", callBack)
  else
      local signParams =App42Service:populateSignParams()
      local metaHeaderParams = App42Service:populateMetaHeaderParams()
      local headerParams = App42Service:merge(signParams,metaHeaderParams)
      local queryParams =  {} 
      -- Deleting the geo JSON        
      local geoJson ={}
      local app42 = {}    
      local geo =  {} 
      local storage =  {} 
      local pointsObj= {}
      pointsObj.point = JSON:encode(geoPointsList)  
      geoJson.points = pointsObj    
      geoJson.storageName = geoStorageName    
      storage.storage = geoJson
      geo.geo = storage
      app42.app42 = geo
      local jsonBody  = JSON:encode(app42)
      App42Log:debug("jsonBody is : "..jsonBody)
      signParams.geoPoints =  jsonBody
      queryParams = signParams;
      local signature =  Util:sign(App42API:getSecretKey(),signParams)
      App42Log:debug("signature is : "..signature)
      headerParams.signature = signature
      headerParams.resource = resource
      local resourceURL = version .."/".. resource.."/points/".. geoStorageName
      RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
end

end

function GeoService:getFbAccessToken()
  return fbAccessToken
end		
function GeoService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function GeoService:getSessionId()
  return sessionId
end		
function GeoService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function GeoService:getAdminKey()
  return adminKey
end		
function GeoService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function GeoService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function GeoService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function GeoService:getSelectKeys()
  return selectKeys
end		
function GeoService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function GeoService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function GeoService:getOrderByAscending()
  return orderByAscending
end		
function GeoService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function GeoService:getAclList()
  return aclList
end		
function GeoService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function GeoService:getPageMaxRecords()
  return pageMaxRecords
end		
function GeoService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function GeoService:getPageOffset()
  return pageOffset
end		
function GeoService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end
return GeoService
