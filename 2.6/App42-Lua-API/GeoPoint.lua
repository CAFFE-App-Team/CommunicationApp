--author Samita Mahajan
local GeoPoint = {}
local markerName = nil
local longitude = nil
local latitude = nil
function GeoPoint:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end


function GeoPoint:getLatitude()
    return self.latitude
end
function GeoPoint:setLatitude(_latitude)
    self.latitude = _latitude  
end
function GeoPoint:getMarkerName()
    return self.markerName
end
function GeoPoint:setMarkerName(_markerName)
    self.markerName = _markerName  
end

function GeoPoint:getLongitude()
    return self.longitude
end
function GeoPoint:setLongitude(_longitude)
    self.longitude = _longitude  
end
function GeoPoint:getStrResponse()
    return self.json
end
function GeoPoint:setStrResponse(_json)
    self.json = _json  
end
function GeoPoint:setResponseSuccess(_success)
    self.success = _success  
end
function GeoPoint:getResponseSuccess()
    return self.success  
end
function GeoPoint:getJSONObject()
		local obj ={}
		obj.lat = self.latitude
		obj.lng = self.longitude
		obj.marker = self.markerName
		return obj
end
return GeoPoint