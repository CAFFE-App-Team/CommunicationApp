local SocialResponseBuilder = {}
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local Social = require("App42-Lua-API.Social")
local Friends = require("App42-Lua-API.Friends")
local FacebookProfile = require("App42-Lua-API.FacebookProfile")
local PublicProfile = require("App42-Lua-API.PublicProfile")
function SocialResponseBuilder:buildResponse(jsonString)
  local social = require("App42-Lua-API.Social")
  local socialJSONObj = App42ResponseBuilder:getServiceJSONObject("social",jsonString)
    if(socialJSONObj == nil) then 
      social:setStrResponse(jsonString)
      social:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
    else 
      social =  SocialResponseBuilder:buildSocialObject(socialJSONObj)
      social:setStrResponse(jsonString)
      social:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(jsonString))
    end
  return social
end

function SocialResponseBuilder:buildSocialObject(socialJSONObject)
  local social  = SocialResponseBuilder:buildObjectFromJSONTree(socialJSONObject)
  local friendArray = {}
 local publicFriendArray = {}
  if socialJSONObject.friends ~= nil then
    local friendsDocArray = socialJSONObject.friends
    if table.getn(friendsDocArray) > 0 then
      for i=1, table.getn(friendsDocArray) do
        friendArray[i] = SocialResponseBuilder:buildFriendsObjectFromJSONTree(friendsDocArray[i])
      end 
    else
        friendArray = SocialResponseBuilder:buildFriendsObjectFromJSONTree(friendsDocArray)
    end
      social:setFriendList(friendArray)
  end
  
   if socialJSONObject.me ~= nil then 
    local meJSONObject = socialJSONObject.me
    local me  = SocialResponseBuilder:buildFacebookObjectFromJSONTree(meJSONObject)
    social:setFacebookProfile(me)
  end
  
   if socialJSONObject.facebookProfile ~= nil then 
    local meJSONObject = socialJSONObject.facebookProfile
    local me  = SocialResponseBuilder:buildOwnFacebookObjectFromJSONTree(meJSONObject)
    social:setFacebookProfile(me)
  end
  
  if socialJSONObject.profile ~= nil then
    local publicFriendsDocArray = socialJSONObject.profile
    if table.getn(publicFriendsDocArray) > 0 then
      for i=1, table.getn(publicFriendsDocArray) do
        publicFriendArray[i] = SocialResponseBuilder:buildPublicFriendsObjectFromJSONTree(publicFriendsDocArray[i])
      end 
    else
        publicFriendArray = SocialResponseBuilder:buildPublicFriendsObjectFromJSONTree(publicFriendsDocArray)
    end
      social:setPublicProfile(publicFriendArray)
  end
  
  return social
end


function SocialResponseBuilder:buildObjectFromJSONTree(json)
  local social = Social:new()
  if(json.userName ~= nil)then
    social:setUserName(json.userName)
  end
  if(json.status ~= nil) then
    social:setStatus(json.status)
  end
  if(json.facebookAppId ~= nil) then
    social:setFacebookAppId(json.facebookAppId)
    end
  if(json.facebookAppSecret ~= nil) then
    social:setFacebookAppSecret(json.facebookAppSecret)
    end
  if(json.facebookAccessToken ~= nil) then
    social:setFacebookAccessToken(json.facebookAccessToken)
  end
  if(json.twitterConsumerKey ~= nil) then
    social:setTwitterConsumerKey(json.twitterConsumerKey)
  end
  if(json.twitterConsumerSecret ~= nil) then
    social:setTwitterConsumerSecret(json.twitterConsumerSecret)
  end 
  if(json.twitterAccessTokenSecret ~= nil) then
    social:setTwitterAccessTokenSecret(json.twitterAccessTokenSecret)
  end
    if(json.twitterAccessToken ~= nil) then
    social:setTwitterAccessToken(json.twitterAccessToken)
  end  
  if(json.linkedinApiKey ~= nil) then
    social:setLinkedinApiKey(json.linkedinApiKey)
  end  
  if(json.linkedinSecretKey ~= nil) then
    social:setLinkedinSecretKey(json.linkedinSecretKey)
  end  
  if(json.linkedinAccessToken ~= nil) then
    social:setLinkedinAccessToken(json.linkedinAccessToken)
  end  
  if(json.linkedinAccessTokenSecret ~= nil) then
    social:setLinkedinAccessTokenSecret(json.linkedinAccessTokenSecret)
  end  
  return social
end

function SocialResponseBuilder:buildFacebookObjectFromJSONTree(json)
  local me = FacebookProfile:new()
  if(json.name ~= nil) then
    me:setName(json.name)
  end
  if(json.picture ~= nil) then
    me:setPicture(json.picture)
    end
  if(json.id ~= nil) then
    me:setId(json.id)
    end
    return me
end

function SocialResponseBuilder:buildFriendsObjectFromJSONTree(json)
  local friends =Friends:new()
  if(json.installed ~= nil)then
    friends:setInstalled(json.installed)
  end
  if(json.name ~= nil) then
    friends:setName(json.name)
  end
  if(json.picture ~= nil) then
    friends:setPicture(json.picture)
    end
  if(json.id ~= nil) then
    friends:setId(json.id)
    end
    return friends
end

function SocialResponseBuilder:buildOwnFacebookObjectFromJSONTree(json)
  local me = FacebookProfile:new()
  if(json.name ~= nil) then
    me:setName(json.name)
  end
  if(json.picture ~= nil) then
    me:setPicture(json.picture)
    end
  if(json.id ~= nil) then
    me:setId(json.id)
  end
  if(json.firstName ~= nil) then
    me:setFirstName(json.firstName)
  end
    if(json.lastName ~= nil) then
    me:setLastName(json.lastName)
  end
    if(json.gender ~= nil) then
    me:setGender(json.gender)
  end
     if(json.link ~= nil) then
    me:setLink(json.link)
  end
    if(json.locale ~= nil) then
    me:setLocale(json.locale)
  end
     if(json.username ~= nil) then
    me:setUserName(json.username)
  end
    return me
end

function SocialResponseBuilder:buildPublicFriendsObjectFromJSONTree(json)
  local me =PublicProfile:new()
  if(json.name ~= nil) then
    me:setName(json.name)
  end
  if(json.picture ~= nil) then
    me:setPicture(json.picture)
    end
  if(json.id ~= nil) then
    me:setId(json.id)
    end
    return me
end


return SocialResponseBuilder