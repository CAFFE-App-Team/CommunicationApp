--author Samita Mahajan
local GeoResponseBuilder = {}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local Geo = require("App42-Lua-API.Geo")
local Point = require("App42-Lua-API.Point")
local JSON = require("App42-Lua-API.JSON") 
function GeoResponseBuilder:buildResponse(jsonString)
  
  local geoObj = require("App42-Lua-API.Geo")
  local geoJSONObj = App42ResponseBuilder:getServiceJSONObject("geo",jsonString) 
  local storageJSONObj = geoJSONObj.storage
    if(storageJSONObj == nil) then 
      geoObj:setStrResponse(jsonString)
      geoObj:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
      geoObj:setTotalRecords(App42ResponseBuilder:getTotalRecords(jsonString))
    else  
      geoObj =  GeoResponseBuilder:buildGeoObject(storageJSONObj)
      geoObj:setStrResponse(jsonString)
      geoObj:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
    end
  return geoObj
end
function GeoResponseBuilder:buildArrayResponse(responseString)
  local geo = Geo:new()
  local geoJSONArray = {}
  local geosJSONObj = App42ResponseBuilder:getServiceJSONObject("geo",responseString)
  local geoJSONObjectArray = geosJSONObj.storage
  if table.getn(geoJSONObjectArray) > 0 then
    for i=1, table.getn(geoJSONObjectArray) do
      geo = GeoResponseBuilder:buildGeoObject(geoJSONObjectArray[i])
      geo:setStrResponse(responseString)
      geo:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
      geoJSONArray[i] = geo
    end    
  else
    geo = GeoResponseBuilder:buildGeoObject(geoJSONObjectArray)
    geo:setStrResponse(responseString)
    geo:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
    geoJSONArray = geo
  end

  return geoJSONArray
end

function GeoResponseBuilder:buildGeoObject(storageJSONObj)
  local geo = GeoResponseBuilder:buildObjectFromJSONTree(storageJSONObj)
   local point = {}
  if storageJSONObj.points ~= nil then 
    local pointsJSONObject  = storageJSONObj.points
    local pointJSONArray = pointsJSONObject.point
    if table.getn(pointJSONArray) > 0 then      
      for i=1, table.getn(pointJSONArray) do     
        point[i] = GeoResponseBuilder:buildPointObjectFromJSONTree(pointJSONArray[i])
      end
    else
        point = GeoResponseBuilder:buildPointObjectFromJSONTree(pointJSONArray)
    end
       geo:setPointList(point)
  end
  return geo
end
function GeoResponseBuilder:buildPointObjectFromJSONTree(json)
  local point =Point:new()
  if(json.lat ~= nil) then
    point:setLatitude(json.lat)
  end
  if(json.marker ~= nil) then
    point:setMarkerName(json.marker)
    end
  if(json.lng ~= nil) then
    point:setLongitude(json.lng)
  end
  return point
end

function GeoResponseBuilder:buildObjectFromJSONTree(json)
  local geo = Geo:new()
  if(json.storageName ~= nil)then
    geo:setStorageName(json.storageName)
  end
  if(json.createdOn ~= nil)then
    geo:setCreatedOn(json.createdOn)
  end
  return geo
end
return GeoResponseBuilder