--author Himanshu Sharma
local GeoTag = {}
local lat 
local lng

function GeoTag:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function GeoTag:getLat()
  return self.lat
end
function GeoTag:setLat(_lat)
  self.lat = _lat
end
function GeoTag:getLng()
  return self.lng
end
function GeoTag:setLng(_lng)
  self.lng = _lng
end
function GeoTag:getJSONObject()
  local jsonObject = {}
  jsonObject.lat = self.lat;
  jsonObject.lng = self.lng;
  return jsonObject
end
return GeoTag