local UploadResponseBuilder={}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local JSON = require("App42-Lua-API.JSON")
local Upload = require("App42-Lua-API.Upload")
local File= require("App42-Lua-API.File")
function UploadResponseBuilder:buildResponse(json)
  local uploadObj = Upload:new()
  local uploadJSONObj = App42ResponseBuilder:getServiceJSONObject("upload",json)
    if uploadJSONObj ~= nil then 
      uploadObj = UploadResponseBuilder:buildUploadObject(uploadJSONObj)
      uploadObj:setStrResponse(json)
      uploadObj:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    else
      uploadObj:setStrResponse(json)
      uploadObj:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
      uploadObj:setTotalRecords(App42ResponseBuilder:getTotalRecords(json))
    end    
  return uploadObj
end
 function UploadResponseBuilder:buildUploadObject(json)
   local upload = Upload:new()
   local fileList = {}
    if json.files ~= nil then
      local jsonObjConfigurations = json.files
      if jsonObjConfigurations.file ~= nil then
        local jsonFileArray = jsonObjConfigurations.file
        if table.getn(jsonFileArray) > 0 then
          for i=1, table.getn(jsonFileArray) do
            fileList[i] = UploadResponseBuilder:buildFileListObject(jsonFileArray[i])
          end 
        else
          fileList = UploadResponseBuilder:buildFileListObject(jsonFileArray)
        end
        upload:setFileList(fileList)
      end
    end
    return upload
end
function UploadResponseBuilder:buildFileListObject(json)
  local filelist = File:new()
  if(json.name ~= nil)then
    filelist:setName(json.name)
  end
  if(json.userName ~= nil) then
    filelist:setUserName(json.userName)
  end
  if(json.type ~= nil) then
    filelist:setType(json.type)
    end
  if(json.url ~= nil) then
    filelist:setUrl(json.url)
  end
  if(json.tinyUrl ~= nil) then
    filelist:setTinyUrl(json.tinyUrl)
  end
   if(json.description ~= nil) then
    filelist:setDescription(json.description)
  end
  
  return filelist
end

return UploadResponseBuilder