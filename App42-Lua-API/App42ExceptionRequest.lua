local JSON  = require("App42-Lua-API.JSON")
local App42Exception  = require("App42-Lua-API.App42Exception")
local App42ExceptionRequest = {}

function App42ExceptionRequest:buildInternalExceptionRequest(exceptionString)
  local app42Exception  = App42Exception:new()
    app42Exception:setMessage(exceptionString)
    app42Exception:setAppErrorCode("null")
    app42Exception:setHttpErrorCode("null")
    app42Exception:setDetails("null")
  return app42Exception
end
function App42ExceptionRequest:buildExceptionRequest(exceptionString)
  local app42Exception  = App42Exception:new()
  local jsonObj = JSON:decode(exceptionString)
  local jsonObjApp42 = jsonObj.app42Fault
  app42Exception:setMessage(jsonObjApp42.message) 
  app42Exception:setAppErrorCode(jsonObjApp42.appErrorCode)
  app42Exception:setHttpErrorCode(jsonObjApp42.httpErrorCode)
  app42Exception:setDetails(jsonObjApp42.details)
  return app42Exception
end
return App42ExceptionRequest