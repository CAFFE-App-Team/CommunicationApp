--author Himanshu Sharma
local Point = {}
local buddyName = nil
local markerName = nil
local longitude = nil
local success = false
local latitude = nil
local createdOn = nil
function Point:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Point:getBuddyName()
    return self.buddyName
end
function Point:setBuddyName(_buddyName)
    self.buddyName = _buddyName  
end
function Point:getLatitude()
    return self.latitude
end
function Point:setLatitude(_latitude)
    self.latitude = _latitude  
end
function Point:getMarkerName()  
    return self.markerName
end
function Point:setMarkerName(_markerName)
    self.markerName = _markerName  
end
function Point:getCreatedOn()
    return self.createdOn
end
function Point:setCreatedOn(_createdOn)
    self.createdOn = _createdOn  
end
function Point:getLongitude()
    return self.longitude
end
function Point:setLongitude(_longitude)
    self.longitude = _longitude  
end
function Point:getStrResponse()
    return self.json
end
function Point:setStrResponse(_json)
    self.json = _json  
end
function Point:setResponseSuccess(_success)
    self.success = _success  
end
function Point:getResponseSuccess()
    return self.success  
end
function Point:getJSONObject()
		local obj ={}
		obj.lat = self.latitude
		obj.lng = self.longitude
		obj.marker = self.markerName
		return obj
end
return Point