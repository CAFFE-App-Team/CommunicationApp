--author Himanshu Sharma
local Storage = {}
local dbName = ""
local recordCount
local collectionName = ""
local success= false
local json = ""
local totalRecords
local jsonDocList = require("App42-Lua-API.JSONDocument")

function Storage:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Storage:getRecordCount()
    return self.recordCount
end
function Storage:setRecordCount(_recordCount)
  self.recordCount = _recordCount
end
function Storage:getDbName()
    return self.dbName
end
function Storage:setDbName(_dbName)
  self.dbName = _dbName
end
function Storage:getJsonDocList()
    return self.jsonDocList
end
function Storage:setJsonDocList(_jsonDocList)
  self.jsonDocList = _jsonDocList
end
function Storage:getCollectionName()
    return self.collectionName
end
function Storage:setCollectionName(_collectionName)
  self.collectionName = _collectionName
end
function Storage:getStrResponse()
    return self.json
end
function Storage:setStrResponse(_json)
    self.json = _json  
end
function Storage:setResponseSuccess(_success)
    self.success = _success  
end
function Storage:getResponseSuccess()
    return self.success  
end
function Storage:getTotalRecords()
    return self.totalRecords
end
function Storage:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end
return Storage