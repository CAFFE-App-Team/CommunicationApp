--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local UploadService =  {}
local orderByDescending = nil
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local aclList = {}
local adminKey = nil
local fbAccessToken = nil
local sessionId = ""
local selectKeys = {}
local otherMetaHeaders = {}  
local resource = "upload"
local version = "1.0"

function UploadService:uploadFile(name,filePath,fileType, description,callBack)
   if description == nil or description =="" or Util:trim(description)==""  or name == nil or name =="" or Util:trim(name)==""  then
    Util:throwExceptionIfNullOrBlank(description,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(name,"Name", callBack)
  else
local signParams =App42Service:populateSignParams()
local metaHeaderParams = App42Service:populateMetaHeaderParams()
local headerParams = App42Service:merge(signParams,metaHeaderParams)
local queryParams =  {} 
local postParams={}
postParams.name = name    
postParams.type = fileType
postParams.description = description
signParams = App42Service:merge(signParams,postParams)
local signature =  Util:sign(App42API:getSecretKey(),signParams)
App42Log:debug("signature is : "..signature)
headerParams.signature = signature
headerParams.resource = resource
local resourceURL = version .."/".. resource
local accept = "application/json"

RestConnector:multiPartRequest("uploadFile",filePath,queryParams,postParams, headerParams, resourceURL,accept,callBack)
end
end
function UploadService:uploadFileForUser( name,  userName,
			 filePath,  fileType,  description,callBack)
 
local signParams =App42Service:populateSignParams()
local metaHeaderParams = App42Service:populateMetaHeaderParams()
local headerParams = App42Service:merge(signParams,metaHeaderParams)
local queryParams =  {} 
local postParams={}
postParams.name = name    	
postParams.userName = userName
postParams.type = fileType
postParams.description = description
signParams = App42Service:merge(signParams,postParams)
local signature =  Util:sign(App42API:getSecretKey(),signParams)
App42Log:debug("signature is : "..signature)
headerParams.signature = signature
headerParams.resource = resource
local resourceURL = version .."/".. resource.."/" .. userName
local accept = "application/json"

RestConnector:multiPartRequest("uploadFile",filePath,queryParams,postParams, headerParams, resourceURL,accept,callBack)
end

function UploadService:getAllFiles(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:getAllFilesCount(callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/count"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:getAllFilesByPaging(max, offset,callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
    signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/paging".."/"..max.."/"..offset
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:getFileByUser(name,  userName, callBack)
    if userName == nil or userName =="" or Util:trim(userName)==""  or name == nil or name =="" or Util:trim(name)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(name,"Name", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {} 
  signParams.name = name
  signParams.userName = userName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.. "/".. userName .. "/" .. name
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
function UploadService:getAllFilesCountByUser(userName, callBack)
    if userName == nil or userName =="" or Util:trim(userName)==""   then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {}   
  signParams.userName = userName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource..  "/".. "user".. "/" .. userName .."/count"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
function UploadService:getAllFilesByUser(userName, callBack)
    if userName == nil or userName =="" or Util:trim(userName)==""   then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {}   
  signParams.userName = userName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource..  "/".."user" .. "/" ..userName
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
function UploadService:getAllFilesByUserByPaging(userName, max, offset , callBack)
   if userName == nil or userName =="" or Util:trim(userName)==""   then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {}   
  signParams.userName = userName 
  signParams.max = max 
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource..  "/"
					.. "user" .."/" ..userName .."/" .. max .. "/" ..offset
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
function UploadService:getFileByName(name, callBack)
   if name == nil or name =="" or Util:trim(name)==""   then
    Util:throwExceptionIfNullOrBlank(name,"Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {}   
    signParams.name = name 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    local resourceURL = version.."/"..resource.. "/".. name
    headerParams.resource = resource
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function UploadService:removeFileByUser( name, userName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)==""  or name == nil or name =="" or Util:trim(name)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
    Util:throwExceptionIfNullOrBlank(name,"Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.name = name 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"
					.. userName .. "/" .. name
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
  end
  function UploadService:removeAllFilesByUser(userName,callBack)
  if userName == nil or userName =="" or Util:trim(userName)==""   then
    Util:throwExceptionIfNullOrBlank(userName,"UserName", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.userName = userName 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/"
					.. "user" .."/" ..userName
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
  
end

 function UploadService:removeFileByName(name,callBack)
  if name == nil or name =="" or Util:trim(name)==""   then
    Util:throwExceptionIfNullOrBlank(name,"Name", callBack)
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.name = name 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .. "/".. name
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end  
end

 function UploadService:removeAllFiles(callBack)
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource
    RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:getFilesCountByType(uploadFileType, callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {}   
  signParams.type = uploadFileType
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/type/"
					.. uploadFileType.. "/count"
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:getFilesByType(uploadFileType, callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {}   
  signParams.type = uploadFileType
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/type/"
					.. uploadFileType
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:getFilesByTypeByPaging(uploadFileType, max,
			offset, callBack)
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  local queryParams =  {}   
  signParams.type = uploadFileType
  signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  local resourceURL = version.."/"..resource.."/type/"
					.. uploadFileType.. "/" .. max .. "/" ..offset
  headerParams.resource = resource
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end

function UploadService:grantAccess(fileName, userName,aclList,callBack)
    if fileName == nil or fileName == "" or Util:trim(fileName) == "" or userName == nil or userName == ""      or Util:trim(userName) == ""  then
    Util:throwExceptionIfNullOrBlank(fileName,"fileName", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.fileName = fileName    
  signParams.userName = userName
  local acl= {}
  local queryParams = {}
  local acls = {}
  acl.acl  = aclList
  acls.acls = JSON:encode(acl)
  local uploadJson ={}
  local app42 = {}   
  local upload = {} 
  uploadJson = acls
  upload.upload = uploadJson
  app42.app42 = upload
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/".. "grantAccess" .. "/"
					.. userName .. "/" .. fileName
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function UploadService:revokeAccess(fileName, userName,aclList,callBack)
    if fileName == nil or fileName == "" or Util:trim(fileName) == "" or userName == nil or userName == ""      or Util:trim(userName) == ""  then
    Util:throwExceptionIfNullOrBlank(fileName,"fileName", callBack)
    Util:throwExceptionIfNullOrBlank(userName,"userName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
   signParams.fileName = fileName    
  signParams.userName = userName
   local acl= {}
  local queryParams = {}
  local acls = {}
  acl.acl  = aclList
  acls.acls = JSON:encode(acl)
  local uploadJson ={}
  local app42 = {}   
  local upload = {} 
  uploadJson = acls
  upload.upload = uploadJson
  app42.app42 = upload
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/".. "revokeAccess" .. "/"
					.. userName .. "/" .. fileName
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function UploadService:getFbAccessToken()
  return fbAccessToken
end		
function UploadService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function UploadService:getSessionId()
  return sessionId
end		
function UploadService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function UploadService:getAdminKey()
  return adminKey
end		
function UploadService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function UploadService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function UploadService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function UploadService:getSelectKeys()
  return selectKeys
end		
function UploadService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function UploadService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function UploadService:getOrderByAscending()
  return orderByAscending
end		
function UploadService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function UploadService:getAclList()
  return aclList
end		
function UploadService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function UploadService:getPageMaxRecords()
  return pageMaxRecords
end		
function UploadService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function UploadService:getPageOffset()
  return pageOffset
end		
function UploadService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end

function UploadService:setQuery(_collectionName,  metaInfoQuery)
  App42Service:setQuery(_collectionName,  metaInfoQuery)
end
function UploadService:addJSONObject(_collectionName, _obj)
    App42Service:addJSONObject(_collectionName, _obj)
end

return UploadService