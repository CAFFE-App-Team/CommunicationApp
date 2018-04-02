--author Himanshu Sharma
local RestConnector = require("App42-Lua-API.RestConnector")
local App42Service = require("App42-Lua-API.App42Service")
local App42API = require("App42-Lua-API.App42API")
local App42Log = require("App42-Lua-API.App42Log")
local Util  = require("App42-Lua-API.Util")
local JSON = require("App42-Lua-API.JSON")
local SocialService =  {}
local queryParams =   {}
local resource = "social"
local version = "1.0"

function SocialService:linkUserFacebookAccount(userName, accessToken,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or accessToken == nil or accessToken== "" or Util:trim(accessToken)==""then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(accessToken,"AccessToken", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.accessToken = accessToken   
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/facebook/linkuser/accesscredentials"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:updateFacebookStatus(userName, status,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or status == nil or status== "" or Util:trim(status)==""then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(status,"status", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.status = status   
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/facebook/updatestatus"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:linkUserTwitterAccountWithCredentials(userName,accessToken,accessTokenSecret, consumerKey,consumerSecret,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or accessToken == nil or accessToken== "" or Util:trim(accessToken)=="" or accessTokenSecret == nil or accessTokenSecret== "" or Util:trim(accessTokenSecret)=="" or consumerKey == nil or consumerKey== "" or Util:trim(consumerKey)=="" or 
    consumerSecret == nil or consumerSecret== "" or Util:trim(consumerSecret)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(accessToken,"accessToken", callBack)
    Util:throwExceptionIfNullOrBlank(accessTokenSecret,"accessTokenSecret", callBack)
    Util:throwExceptionIfNullOrBlank(consumerKey,"consumerKey", callBack)
     Util:throwExceptionIfNullOrBlank(consumerSecret,"consumerSecret", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.consumerKey = consumerKey
    socialJson.consumerSecret = consumerSecret   
    socialJson.accessToken = accessToken   
    socialJson.accessTokenSecret = accessTokenSecret  
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/twitter/linkuser"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:linkUserTwitterAccount(userName,accessToken,accessTokenSecret,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or accessToken == nil or accessToken== "" or Util:trim(accessToken)=="" or accessTokenSecret == nil or accessTokenSecret== "" or Util:trim(accessTokenSecret)==""  then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
    Util:throwExceptionIfNullOrBlank(accessToken,"accessToken", callBack)
    Util:throwExceptionIfNullOrBlank(accessTokenSecret,"accessTokenSecret", callBack)
   else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.accessToken = accessToken   
    socialJson.accessTokenSecret = accessTokenSecret  
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/twitter/linkuser/accesscredentials"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:updateTwitterStatus(userName, status,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or status == nil or status== "" or Util:trim(status)==""then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(status,"status", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.status = status   
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/twitter/updatestatus"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:linkUserLinkedInAccountWithCredentials(userName,accessToken,accessTokenSecret,apiKey,secretKey,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or accessToken == nil or accessToken== "" or Util:trim(accessToken)=="" or accessTokenSecret == nil or accessTokenSecret== "" or Util:trim(accessTokenSecret)==""  or apiKey == nil or apiKey== "" or Util:trim(apiKey)=="" or  secretKey == nil or secretKey== "" or Util:trim(secretKey)=="" then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(accessToken,"accessToken", callBack)
     Util:throwExceptionIfNullOrBlank(accessTokenSecret,"accessTokenSecret", callBack)
     Util:throwExceptionIfNullOrBlank(apiKey,"apiKey", callBack)
     Util:throwExceptionIfNullOrBlank(secretKey,"secretKey", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.apiKey = apiKey   
    socialJson.secretKey = secretKey   
    socialJson.accessToken = accessToken   
    socialJson.accessTokenSecret = accessTokenSecret  
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/linkedin/linkuser"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:linkUserLinkedInAccount(userName,accessToken,accessTokenSecret,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or accessToken == nil or accessToken== "" or Util:trim(accessToken)=="" or accessTokenSecret == nil or accessTokenSecret== "" or Util:trim(accessTokenSecret)==""   then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(accessToken,"accessToken", callBack)
     Util:throwExceptionIfNullOrBlank(accessTokenSecret,"accessTokenSecret", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.accessToken = accessToken   
    socialJson.accessTokenSecret = accessTokenSecret  
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/linkedin/linkuser/accesscredentials"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:updateLinkedInStatus(userName, status,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or status == nil or status== "" or Util:trim(status)==""then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(status,"status", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.status = status   
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/linkedin/updatestatus"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end


function SocialService:updateSocialStatusForAll(userName, status,callBack)  
  if userName == nil or userName== "" or Util:trim(userName)=="" or status == nil or status== "" or Util:trim(status)==""then
     Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)
     Util:throwExceptionIfNullOrBlank(status,"status", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.userName = userName   
    socialJson.status = status   
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/social/updatestatus/all"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:getFacebookFriendsFromLinkUser(userName,callBack)
  if userName == nil or userName == "" or Util:trim(userName) == "" then
    Util:throwExceptionIfNullOrBlank(userName,"User Name", callBack)  
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
    local resourceURL = version.."/"..resource .."/".."facebook/friends/"..userName
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function SocialService:getFacebookFriendsFromAccessToken(accessToken,callBack)
  if accessToken == nil or accessToken == "" or Util:trim(accessToken) == "" then
    Util:throwExceptionIfNullOrBlank(accessToken,"Access Token", callBack)  
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.accessToken = accessToken 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/facebook/friends/OAuth/"..accessToken
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end

function SocialService:facebookLinkPost(accessToken,link,message,callBack)  
  if accessToken == nil or accessToken== "" or Util:trim(accessToken)=="" or link == nil or link== "" or Util:trim(link)=="" or message == nil or message== "" or Util:trim(message)=="" then
     Util:throwExceptionIfNullOrBlank(accessToken,"Access Token", callBack)
     Util:throwExceptionIfNullOrBlank(link,"link", callBack)
     Util:throwExceptionIfNullOrBlank(message,"message", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.link = link   
    socialJson.accessToken = accessToken  
    socialJson.message = message 
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/facebook/publishstream"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end


function SocialService:facebookLinkPostWithCustomThumbnail(accessToken,link,message,pictureUrl,
		name, description,callBack)  
  if accessToken == nil or accessToken== "" or Util:trim(accessToken)=="" or link == nil or link== "" or Util:trim(link)=="" or message == nil or message== "" or Util:trim(message)=="" or pictureUrl == nil or pictureUrl== "" or Util:trim(pictureUrl)==""  or  name == nil or name== "" or Util:trim(name)=="" or description == nil or description== "" or Util:trim(description)=="" then
     Util:throwExceptionIfNullOrBlank(accessToken,"Access Token", callBack)
     Util:throwExceptionIfNullOrBlank(link,"link", callBack)
     Util:throwExceptionIfNullOrBlank(message,"message", callBack)
     Util:throwExceptionIfNullOrBlank(pictureUrl,"PictureUrl", callBack)
     Util:throwExceptionIfNullOrBlank(name,"name", callBack)
     Util:throwExceptionIfNullOrBlank(description,"description", callBack)
  else
    local signParams =  App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local socialJson ={}
    local app42 = {} 
    local social =  {}  
    socialJson.link = link   
    socialJson.accessToken = accessToken  
    socialJson.message = message 
    socialJson.picture = pictureUrl 
    socialJson.name = name 
    socialJson.description = description 
    social.social = socialJson
    app42.app42 = social
    local jsonBody  = JSON:encode(app42)
    App42Log:debug("jsonBody is : "..jsonBody)
    signParams.body =  jsonBody
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version .."/".. resource.."/facebook/publishstream"
    RestConnector:executePost(resourceURL,queryParams,jsonBody,headerParams,callBack)  
  end
end

function SocialService:getFacebookProfile(accessToken,callBack)
  if accessToken == nil or accessToken == "" or Util:trim(accessToken) == "" then
    Util:throwExceptionIfNullOrBlank(accessToken,"Access Token", callBack)  
  else
    local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    signParams.accessToken = accessToken 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/facebook/me/OAuth/"..accessToken
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
  end
end


function SocialService:getFacebookProfilesFromIds(facebookIds,callBack)
     local signParams =App42Service:populateSignParams()
    local metaHeaderParams = App42Service:populateMetaHeaderParams()
    local headerParams = App42Service:merge(signParams,metaHeaderParams)
    local queryParams =  {} 
    headerParams.userList =  JSON:encode(facebookIds) 
    local signature =  Util:sign(App42API:getSecretKey(),signParams)
    App42Log:debug("signature is : "..signature)
    headerParams.signature = signature
    headerParams.resource = resource
    local resourceURL = version.."/"..resource .."/facebook/ids"
    RestConnector:executeGet(resourceURL,queryParams,headerParams,callBack)
 end


return SocialService
