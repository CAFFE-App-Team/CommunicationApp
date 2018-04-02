local Upload = {}
local success= false
local json = ""
local totalRecords
local fileList = require("App42-Lua-API.File")
function Upload:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Upload:getFileList()
    return self.fileList
end
function Upload:setFileList(_fileList)
  self.fileList = _fileList
end
function Upload:getStrResponse()
    return self.json
end
function Upload:setStrResponse(_json)
    self.json = _json  
end
function Upload:setResponseSuccess(_success)
    self.success = _success  
end
function Upload:getResponseSuccess()
    return self.success  
end
function Upload:getTotalRecords()
    return self.totalRecords
end
function Upload:setTotalRecords(_totalRecords)
    self.totalRecords = _totalRecords  
end
return Upload