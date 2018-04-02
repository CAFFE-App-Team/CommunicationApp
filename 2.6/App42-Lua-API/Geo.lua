--author Samita Mahajna
local Geo = {}
local storageName;
local sourceLat;
local sourceLng;
local distanceInKM;
local createdOn;
local json
local pointList = require("App42-Lua-API.Point")

function Geo:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Returns the name of the storage.
--return the name of the storage.

function Geo:getStorageName()
    return self.storageName
end

--Sets the name of the storage.
--storageName - name of the storage.
function Geo:setStorageName(_storageName)
    self.storageName = _storageName  
end

-- Returns the source lat point for geo.
--return the source lat point for geo.
function Geo:getSourceLat() 
		return self.sourceLat;
end

-- Sets the source lat point for geo.
-- sourceLat - source lat point for geo.

function Geo:setSourceLat(_sourceLat)
		self.sourceLat = _sourceLat;
end

-- Returns the source lng point for geo.
-- @return the source lng point for geo.

function Geo:getSourceLng() 
		return self.sourceLng;
end

-- Sets the source lng point for geo.
-- @param sourceLng - source lng point for geo.

function Geo:setSourceLng(_sourceLng)
		self.sourceLng = _sourceLng;
end

-- Returns the distance in km for geo.
-- @return the distance in km for geo.

function Geo:getDistanceInKM() 
		return self.distanceInKM;
end

-- Sets the distance in km for geo.
--  @param distanceInKM distance in km for geo.

function Geo:setDistanceInKM(_distanceInKM) 
		self.distanceInKM = _distanceInKM;
end

-- Returns the time, day and date when the geo was created.
-- @return the time, day and date when the geo was created.

function Geo:getCreatedOn()
		return self.createdOn;
end

-- Sets the time, day and date when the geo was created.
-- @param createdOn - time, day and date when the geo was created.

function Geo:setCreatedOn(_createdOn) 
		self.createdOn = _createdOn;
end

-- Returns the list of all the points in the geo.
-- @return the list of all the points in the geo.

function Geo:getPointList()
    return self.pointList
end

-- Sets the list of all the points in the geo.
-- @param pointList
-- list of all the points in the geo.

function Geo:setPointList(_pointList)
    self.pointList = _pointList  
end

function Geo:getStrResponse()
    return self.json
end
function Geo:setStrResponse(_json)
    self.json = _json  
end

function Geo:setResponseSuccess(_success)
    self.success = _success  
end
function Geo:getResponseSuccess()
    return self.success  
end
return Geo