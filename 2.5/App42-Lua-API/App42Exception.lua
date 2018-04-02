local App42Exception = {}
local message = ""
local details = ""
local appErrorCode
local httpErrorCode

function App42Exception:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end

function App42Exception:getMessage()
    return self.message
end
function App42Exception:setMessage(_message)
    self.message = _message
end
function App42Exception:getAppErrorCode()
    return self.appErrorCode
end
function App42Exception:setAppErrorCode(_appErrorCode)
  self.appErrorCode = _appErrorCode
end
function App42Exception:getHttpErrorCode()
    return self.httpErrorCode
end
function App42Exception:setHttpErrorCode(_httpErrorCode)
  self.httpErrorCode = _httpErrorCode
end
function App42Exception:getDetails()
    return self.details
end
function App42Exception:setDetails(_details)
  self.details = _details
end

return App42Exception