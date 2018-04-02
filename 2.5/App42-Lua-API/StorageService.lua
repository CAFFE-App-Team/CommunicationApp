--Storage service on cloud provides the way to store the JSON document in NoSQL
--database running on cloud. One can store the JSON document, update it ,
--search it and can apply the map-reduce search on stored documents. Example :
--If one will store JSON doc {"employeeName":"Nick"} it will be stored with unique
--Object Id and stored JSON object will look like {"employeeName":"Nick", "_id" : {
--"$oid" : "4f423dcce1603b3f0bd560cf"}}. This oid can further be used to
--access/search the document.
--@author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local StorageService =  {}
local orderByDescending = nil 
local orderByAscending = nil
local pageOffset = -1
local pageMaxRecords = -1
local queryParams =  {}  
local aclList = nil
local adminKey = nil
local fbAccessToken = nil
local sessionId = nil
local selectKeys = {}
local otherMetaHeaders = {} 
local resource = "storage"
local version = "1.0"
local geoTag = nil
local event =""
--Save the JSON document in given database name and collection name.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc has to be saved
--json - Target JSON document to be saved
--callback - Callback object for success/exception result
function StorageService:insertJSONDocument(dbName,collectionName,jsonObject,callBack)
  if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  local storageJson ={}
  local app42 = {}   
  local storage = {} 
  storageJson.jsonDoc = jsonObject
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/insert/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
--Find all documents stored in given database and collection.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--callback - Callback object for success/exception result
function StorageService:findAllDocuments(dbName,collectionName,callBack)
    if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName 
  signParams.collectionName = collectionName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource .."/findAll/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
--Find all documents stored in given database and collection.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--max - Maximum number of records to be fetched
--offset - From where the records are to be fetched
--calback - Callback object for success/exception result
function StorageService:findAllDocumentsByPaging(dbName,collectionName,max,offset,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName 
  signParams.collectionName = collectionName
  signParams.max = max
  signParams.offset = offset
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findAll/dbName/"..dbName.."/collectionName/"..collectionName.."/"..max.."/".. offset
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
end
end
--Find all collections stored in given database.
--dbName - Unique handler for storage name
--calback - Callback object for success/exception result
function StorageService:findAllCollections(dbName,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findCollections/dbName/"..dbName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Gets the count of all documents stored in given database and collection.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--calback - Callback object for success/exception result
function StorageService:findAllDocumentsCount(dbName,collectionName,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findAll/count/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Find all documents stored in given database and collection.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--docId  - Unique Object Id handler
--calback - Callback object for success/exception result
function StorageService:findDocumentById(dbName,collectionName,docId,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or docId == nil or docId == "" or Util:trim(docId) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(docId,"docId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams["dbName"] = dbName   
  signParams["collectionName"] = collectionName 
  signParams["docId"] = docId
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findDocById/dbName/"..dbName.."/collectionName/"..collectionName.."/docId/"..docId
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

--Find target document using key value search parameter. This key value pair will be searched in the JSON doc stored on the cloud --and matching Doc will be returned as a result of this method.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--key - Key to be searched for target JSON doc
--value - Value to be searched for target JSON doc
--calback - Callback object for success/exception result
function StorageService:findDocumentByKeyValue(dbName,collectionName,key,value,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or key == nil or key == "" or Util:trim(key) == "" or value == nil or value == "" or Util:trim(value) == ""then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(key,"key", callBack)
       Util:throwExceptionIfNullOrBlank(value,"value", callBack)
  else
   local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.key = key 
  signParams.value = value 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findDocByKV/dbName/"..dbName.."/collectionName/"..collectionName.."/"..key.."/"..   value
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Find target document using Custom Query:
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--query - Query Object containing custom query for searching docs
--calback - Callback object for success/exception result
function StorageService:findDocumentsByLocation(dbName,collectionName,query,callBack)
  if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local queryParams = {}
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  queryParams.jsonQuery = Util:queryLength(query)
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.jsonQuery = Util:queryLength(query)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findDocsBylocation/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Find target document using Custom Query:
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--query - Query Object containing custom query for searching docs
--calback - Callback object for success/exception result
function StorageService:findDocumentsByQuery(dbName,collectionName,query,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local queryParams = {}
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  queryParams.jsonQuery = Util:queryLength(query)
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.jsonQuery = Util:queryLength(query)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findDocsByQuery/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Find target document using Custom Query:
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--query - Query Object containing custom query for searching docs
--max  - max result parameter
--offset - offset result parameter
--calback - Callback object for success/exception result
function StorageService:findDocumentsByQueryWithPaging(dbName,collectionName,query,max,offset,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local queryParams = {}
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  queryParams.jsonQuery = Util:queryLength(query)
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.max = max 
  signParams.offset = offset 
  signParams.jsonQuery = Util:queryLength(query)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findDocsByQuery/dbName/"..dbName.."/collectionName/"..collectionName.."/"..max.."/"  ..offset
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

--Find target document using Custom Query:
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--query - Query Object containing custom query for searching docs
--max  - max result parameter
--offset - offset result parameter
--calback - Callback object for success/exception result
function StorageService:findDocsWithQueryPagingOrderBy(dbName,collectionName,query,max,offset,orderByKey,orderByType,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local queryParams = {}
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams)
  queryParams.jsonQuery = Util:queryLength(query)
  queryParams.orderByKey = orderByKey
  queryParams.orderByType = orderByType
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.max = max 
  signParams.offset = offset 
  signParams.jsonQuery = Util:queryLength(query)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/findDocsByQuery/dbName/"..dbName.."/collectionName/"..collectionName.."/"..max.."/"  ..offset
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end
--Update target document using key value search parameter. This key value pair will be searched in the JSON doc stored in the --cloud and matching Doc will be updated with new value passed. 
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--key - Key to be searched for target JSON doc
--value - Value to be searched for target JSON doc
--jsonObject - New Json document to be added
--callback - Callback object for success/exception result
function StorageService:updateDocumentByKeyValue(dbName,collectionName,key,value,jsonObject,callBack)
  if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or key == nil or key == "" or Util:trim(key) == "" or value == nil or value == "" or Util:trim(value) == ""then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(key,"key", callBack)
       Util:throwExceptionIfNullOrBlank(value,"value", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  signParams.key = key
  signParams.value = value  
  local storageJson ={}
  local app42 = {}   
  local storage = {} 
  storageJson.jsonDoc = jsonObject
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/update/dbName/"..dbName.."/collectionName/"..collectionName.."/"..key.."/"..value
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
--Update target document using the document id.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--docId - Id of the document to be searched for target JSON doc
--jsonObject - New Json document to be added
--callback - Callback object for success/exception result
function StorageService:updateDocumentByDocId(dbName,collectionName,docId,jsonObject,callBack)
  if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or docId == nil or docId == "" or Util:trim(docId) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(docId,"docId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  signParams.docId = docId  
  local storageJson ={}
  local app42 = {}   
  local storage = {} 
  storageJson.jsonDoc = jsonObject
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/updateByDocId/dbName/"..dbName.."/collectionName/"..collectionName.."/docId/"..docId
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
--Delete target document using Object Id from given db and collection. The Object Id will be searched in the JSON doc stored on the 
--cloud and matching Doc will be deleted.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--docId - Unique Object Id handler
--callback - Callback object for success/exception result
function StorageService:deleteDocumentById(dbName,collectionName,docId,callBack)
  if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or docId == nil or docId == "" or Util:trim(docId) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(docId,"docId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.docId = docId 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/deleteDocById/dbName/"..dbName.."/collectionName/"..collectionName.."/docId/"..docId
  RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end

function StorageService:deleteAllDocuments(dbName,collectionName,callBack)
     if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName 
  signParams.collectionName = collectionName
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource .."/deleteAll/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end
--Delete target document using key and value from given db and collection. The key value will be searched in the JSON doc stored --on the cloud and matching value will be deleted.
--dbName - Unique handler for storage name
--collectionName - Name of collection under which JSON doc needs to be searched
--key - Unique key handler
--value - Unique value handler
--callback - Callback object for success/exception result
function StorageService:deleteDocumentsByKeyValue(dbName,collectionName,key,value,callBack)
    if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or key == nil or key == "" or Util:trim(key) == "" or value == nil or value == "" or Util:trim(value) == ""then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(key,"key", callBack)
       Util:throwExceptionIfNullOrBlank(value,"value", callBack)
  else
  local queryParams = {}
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams= App42Service:merge(signParams,metaHeaderParams) 
  local getValue = {}
  getValue.key = value
  queryParams.value = JSON:encode(getValue)
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.key = key 
  signParams.value = JSON:encode(getValue) 
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/deletebykey/dbName/"..dbName.."/collectionName/"..collectionName.."/"..key
  RestConnector:executeDelete(resourceURL,queryParams,headerParams,callBack)
  end
end
function StorageService:saveOrupdateDocumentByKeyValue(dbName,collectionName,key,value,jsonObject,callBack)
    if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or key == nil or key == "" or Util:trim(key) == "" or value == nil or value == "" or Util:trim(value) == ""then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(key,"key", callBack)
       Util:throwExceptionIfNullOrBlank(value,"value", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  signParams.key = key
  signParams.value = value
  local storageJson ={}
  local app42 = {}   
  local storage = {} 
  storageJson.jsonDoc = jsonObject
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/saveorupdate/dbName/"..dbName.."/collectionName/"..collectionName.."/"..key.."/"..value
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function StorageService:updateDocumentByQuery(dbName,collectionName,query,newJsonDoc,callBack)
    if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  local storageJson ={}
  local app42 = {}   
  local storage = {}  
  storageJson.jsonDoc = newJsonDoc  
  storageJson.jsonQuery = query
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/updateDocsByQuery/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function StorageService:addOrUpdateKeys(dbName, collectionName, docId, keys, callBack)
     if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""  or Util:trim(collectionName) == "" or docId == nil or docId == "" or Util:trim(docId) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
    Util:throwExceptionIfNullOrBlank(docId,"docId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  signParams.docId= docId
  local storageJson ={}
  local app42 = {}   
  local storage = {}  
  storageJson.jsonDoc = keys  
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version.."/"..resource.."/updateKeysByDocId/dbName/"..dbName.."/collectionName/"..collectionName.."/docId/"..docId
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function StorageService:grantAccessOnDoc(dbName,collectionName,docId,aclList,callBack)
    if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or docId == nil or docId == "" or Util:trim(docId) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(docId,"docId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  signParams.docId = docId
  local acl= {}
  local acls = {}
  acl.acl  = aclList
  acls.acls = JSON:encode(acl)
  local storageJson ={}
  local app42 = {}   
  local storage = {} 
  storageJson = acls
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/grantAccessOnDoc/"..dbName.."/"..collectionName.."/"..docId
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end
function StorageService:revokeAccessOnDoc(dbName,collectionName,docId,aclList,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == "" or docId == nil or docId == "" or Util:trim(docId) == "" then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
     Util:throwExceptionIfNullOrBlank(docId,"docId", callBack)
  else
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  signParams.dbName = dbName    
  signParams.collectionName = collectionName
  signParams.docId = docId
  local acl= {}
  local acls = {}
  acl.acl  = aclList
  acls.acls = JSON:encode(acl)
  local storageJson ={}
  local app42 = {}   
  local storage = {} 
  storageJson = acls
  storage.storage = storageJson
  app42.app42 = storage
  local jsonBody  = JSON:encode(app42)
  App42Log:debug("jsonBody is : "..jsonBody)
  signParams.body =  jsonBody
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  local resourceURL = version .."/".. resource.."/revokeAccessOnDoc/"..dbName.."/"..collectionName.."/"..docId
  RestConnector:executePut(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function StorageService:getCountByQuery(dbName,collectionName,query,callBack)
   if dbName == nil or dbName == "" or Util:trim(dbName) == "" or collectionName == nil or collectionName == ""      or Util:trim(collectionName) == ""  then
    Util:throwExceptionIfNullOrBlank(dbName,"dbName", callBack)
    Util:throwExceptionIfNullOrBlank(collectionName,"collectionName", callBack)
  else
  local queryParams = {}
  local signParams =App42Service:populateSignParams()
  local metaHeaderParams = App42Service:populateMetaHeaderParams()
  local headerParams = App42Service:merge(signParams,metaHeaderParams) 
  queryParams.jsonQuery = Util:queryLength(query)
  signParams.dbName = dbName   
  signParams.collectionName = collectionName 
  signParams.jsonQuery = Util:queryLength(query)
  local signature =  Util:sign(App42API:getSecretKey(),signParams)
  App42Log:debug("signature is : "..signature)
  headerParams.signature = signature
  headerParams.resource = resource
  headerParams.operation = "queryCount"
  local resourceURL = version.."/"..resource.."/findDocsByQuery/dbName/"..dbName.."/collectionName/"..collectionName
  RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function StorageService:getFbAccessToken()
  return fbAccessToken
end		
function StorageService:setFbAccessToken(_fbAccessToken)
  App42Service:setFbAccessToken(_fbAccessToken)
  fbAccessToken =  _fbAccessToken
end		
function StorageService:getSessionId()
  return sessionId
end		
function StorageService:setSessionId(_sessionId)
  App42Service:setSessionId(_sessionId)
  sessionId =  _sessionId
end		
function StorageService:getAdminKey()
  return adminKey
end		
function StorageService:setAdminKey(_adminKey)
  App42Service:setAdminKey(_adminKey)
  adminKey =  _adminKey
end		
function StorageService:getOtherMetaHeaders()
  return otherMetaHeaders
end		
function StorageService:setOtherMetaHeaders(_otherMetaHeaders)
  App42Service:setOtherMetaHeaders(_otherMetaHeaders)
  otherMetaHeaders =  _otherMetaHeaders
end		
function StorageService:getSelectKeys()
  return selectKeys
end		
function StorageService:setSelectKeys(_selectKeys)
  App42Service:setSelectKeys(_selectKeys)
  selectKeys = _selectKeys
end		
function App42Service:getOrderByDescending()
  return orderByDescending
end		
function StorageService:setOrderByDescending(_orderByDescending)
   App42Service:setOrderByDescending(_orderByDescending)
  orderByDescending = _orderByDescending
end		
function StorageService:getOrderByAscending()
  return orderByAscending
end		
function StorageService:setOrderByAscending(_orderByAscending)
   App42Service:setOrderByAscending(_orderByAscending)
  orderByAscending = _orderByAscending
end		
function StorageService:getAclList()
  return aclList
end		
function StorageService:setAclList(_aclList)
  App42Service:setAclList(_aclList)
  aclList = _aclList
end
function StorageService:getPageMaxRecords()
  return pageMaxRecords
end		
function StorageService:setPageMaxRecords(_pageMaxRecords)
  App42Service:setPageMaxRecords(_pageMaxRecords)
  pageMaxRecords = _pageMaxRecords
end		
function StorageService:getPageOffset()
  return pageOffset
end		
function StorageService:setPageOffset(_pageOffset)
  App42Service:setPageOffset(_pageOffset)
  pageOffset = _pageOffset
end		
function StorageService:getGeoTag()
  return geoTag
end		
function StorageService:setGeoTag(_geoTag)
  App42Service:setGeoTag(_geoTag)
  geoTag = _geoTag
end		

function StorageService:setEvent(_event)
  App42Service:setEvent(_event)
  event = _event
end	
return StorageService