--author Himanshu Sharma
local  App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local JSON = require("App42-Lua-API.JSON")
local ACL = require("App42-Lua-API.ACL")
local JSONDocument = require("App42-Lua-API.JSONDocument")
local GeoTag = require("App42-Lua-API.GeoTag")
local Storage = require("App42-Lua-API.Storage")
local StorageResponseBuilder = {}

function StorageResponseBuilder:buildResponse(jsonString)
  local storage = require("App42-Lua-API.Storage")
  local storageJSONObj = App42ResponseBuilder:getServiceJSONObject("storage",jsonString)
    if(storageJSONObj == nil) then 
      storage:setStrResponse(jsonString)
      storage:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
      storage:setTotalRecords(App42ResponseBuilder:getTotalRecords(jsonString))
    else 
      storage =  StorageResponseBuilder:buildStorageObject(storageJSONObj)
      storage:setStrResponse(jsonString)
      storage:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
    end
  return storage
end
function StorageResponseBuilder:buildStorageObject(jsonObject)
  local storage =  StorageResponseBuilder:buildObjectFromJSONTree(jsonObject)
  local documentArray = {}
  if jsonObject.jsonDoc ~= nil then
    local jsonDocArray = jsonObject.jsonDoc
    if table.getn(jsonDocArray) > 0 then
      for i=1, table.getn(jsonDocArray) do
        documentArray[i] = StorageResponseBuilder:buildJsonDocument(jsonDocArray[i])
      end 
    else
        documentArray = StorageResponseBuilder:buildJsonDocument(jsonDocArray)
    end
      storage:setJsonDocList(documentArray)
  end
  return storage
end
function StorageResponseBuilder:buildJsonDocument(documentJSON)
  local jsonDcoument =JSONDocument:new();
    if documentJSON["_id"] ~=nil then 
      local idJSONObject = documentJSON["_id"]
      jsonDcoument:setDocId(idJSONObject["$oid"])
      documentJSON["_id"] = nil
    end
    if documentJSON["_$owner"] ~=nil then 
      local ownerJSONObject = documentJSON["_$owner"]
      jsonDcoument:setOwner(ownerJSONObject["owner"])
      documentJSON["_$owner"] = nil
    end
    if documentJSON["_$updatedAt"] ~=nil then 
      local updatedJSONObject = documentJSON["_$updatedAt"]
      jsonDcoument:setUpdatedAt(updatedJSONObject)
      documentJSON["_$updatedAt"] = nil
    end
    if documentJSON["_$createdAt"] ~=nil then 
      local createAtJSONObject = documentJSON["_$createdAt"]
      jsonDcoument:setCreatedAt(createAtJSONObject)
      documentJSON["_$createdAt"] = nil
    end
    if documentJSON["loc"] ~=nil then 
      local locationJSONArray = documentJSON["loc"]
      local geoTag =GeoTag:new()
        geoTag:setLat(locationJSONArray[1])
        geoTag:setLng(locationJSONArray[2])
      jsonDcoument:setLocation(geoTag)
      documentJSON["loc"] = nil
    end
    if documentJSON["_$event"] ~=nil then 
      local eventJSONObject = documentJSON["_$event"]
      jsonDcoument:setEvent(eventJSONObject)
      documentJSON["_$event"] = nil
    end
    if documentJSON["_$acl"] ~=nil then 
      local aclArrayObject = {}
      local aclArray = documentJSON["_$acl"]
        for j=1,table.getn(aclArray) do
          for stringKey, stringValue in sortKeyByValue(aclArray[j]) do
            local acl = ACL:new()
            acl:setUser(stringKey)      
            acl:setPermission(stringValue)
            aclArrayObject[j] = acl
          end
        end
      jsonDcoument:setAclList(aclArrayObject)
      documentJSON["_$acl"] = nil
    end
    jsonDcoument:setJsonDoc(documentJSON)
  return jsonDcoument
end
function StorageResponseBuilder:buildObjectFromJSONTree(jsonObject)
  local object  = Storage:new()
  if(jsonObject.dbName ~= nil)then
    object:setDbName(jsonObject.dbName)
  end
  if(jsonObject.collectionName ~= nil) then
    object:setCollectionName(jsonObject.collectionName)
  end
  if(jsonObject.recordCount ~= nil) then
    object:setRecordCount(jsonObject.recordCount)
  end
  return object
end
return StorageResponseBuilder