--author Himanshu Sharma
local Util = require("App42-Lua-API.Util")
local App42Config = {}
local baseURL = "https://api.shephertz.com/cloud/"
local protocol = "http://";
local rootURL = nil;
local serverName  = "/App42_API_SERVER/cloud/";
local contentType  = "application/json";
local accept  = "application/json";
local customCodeURL = "https://customcode.shephertz.com/"
		
function App42Config:setLocalURL(protocol,host,port)
    baseURL = protocol..host..":"..port..serverName
end
function App42Config:getCustomCodeURL()
    return customCodeURL 
end
function App42Config:setCustomCodeURL(_customCodeURL)
    customCodeURL = _customCodeURL
end
function App42Config:getBaseURL()
    return baseURL 
end
function App42Config:setBaseURL(_baseURL)
    baseURL = _baseURL .."/cloud/"
end
function App42Config:getLocalURL()
    return baseURL 
end
function App42Config:setContentType(_contentType)
    contentType =_contentType
end
function App42Config:getContentType()
   return contentType 
end
function App42Config:setAccept(_accept)
    accept =_accept
end
function App42Config:getAccept()
   return accept 
end
return App42Config
