local Social = {}
local success= false
local json = ""
local userName;
local status;
local facebookAppId;
local facebookAppSecret;
local facebookAccessToken;
local twitterConsumerKey;
local twitterConsumerSecret;
local twitterAccessToken;
local twitterAccessTokenSecret;
local linkedinApiKey;
local linkedinSecretKey;
local linkedinAccessToken;
local linkedinAccessTokenSecret;
local friendsList = require("App42-Lua-API.Friends")
local facebookProfile = require("App42-Lua-API.FacebookProfile")
local publicProfile = require("App42-Lua-API.PublicProfile")
function Social:new()
  o = {}
  setmetatable(o, self)
  self.__index = self
  return o
end
function Social:getUserName()
    return self.userName
end
function Social:setUserName(_userName)
    self.userName = _userName  
end

function Social:getStatus()
    return self.status
end
function Social:setStatus(_status)
    self.status = _status 
end

function Social:getFacebookAppId()
    return self.facebookAppId
end
function Social:setFacebookAppId(_facebookAppId)
    self.facebookAppId = _facebookAppId
end
function Social:getFacebookAppSecret()
    return self.facebookAppSecret
end
function Social:setFacebookAppSecret(_facebookAppSecret)
    self.facebookAppSecret = _facebookAppSecret
end

function Social:getFacebookAccessToken()
    return self.facebookAccessToken
end
function Social:setFacebookAccessToken(_facebookAccessToken)
    self.facebookAccessToken = _facebookAccessToken
end

function Social:getTwitterConsumerKey()
    return self.twitterConsumerKey
end
function Social:setTwitterConsumerKey(_twitterConsumerKey)
    self.twitterConsumerKey = _twitterConsumerKey
end

function Social:getTwitterConsumerSecret()
    return self.twitterConsumerSecret
end
function Social:setTwitterConsumerSecret(_twitterConsumerSecret)
    self.twitterConsumerSecret = _twitterConsumerSecret
end

function Social:getTwitterAccessToken()
    return self.twitterAccessToken
end
function Social:setTwitterAccessToken(_twitterAccessToken)
    self.twitterAccessToken = _twitterAccessToken
end

function Social:getTwitterAccessTokenSecret()
    return self.twitterAccessTokenSecret
end
function Social:setTwitterAccessTokenSecret(_twitterAccessTokenSecret)
    self.twitterAccessTokenSecret = _twitterAccessTokenSecret
end

function Social:getLinkedinApiKey()
    return self.linkedinApiKey
end
function Social:setLinkedinApiKey(_linkedinApiKey)
    self.linkedinApiKey = _linkedinApiKey
end

function Social:getLinkedinSecretKey()
    return self.linkedinSecretKey
end
function Social:setLinkedinSecretKey(_linkedinSecretKey)
    self.linkedinSecretKey = _linkedinSecretKey
end

function Social:getLinkedinAccessToken()
    return self.linkedinAccessToken
end
function Social:setLinkedinAccessToken(_linkedinAccessToken)
    self.linkedinAccessToken = _linkedinAccessToken
end

function Social:getLinkedinAccessTokenSecret()
    return self.linkedinAccessTokenSecret
end
function Social:setLinkedinAccessTokenSecret(_linkedinAccessTokenSecret)
    self.linkedinAccessTokenSecret = _linkedinAccessTokenSecret
end

function Social:getFriendList()
    return self.friendsList
end
function Social:setFriendList(_friendsList)
  self.friendsList = _friendsList
end

function Social:getFacebookProfile()
    return self.facebookProfile
end
function Social:setFacebookProfile(_facebookProfile)
  self.facebookProfile = _facebookProfile
end

function Social:getPublicProfile()
    return self.publicProfile
end
function Social:setPublicProfile(_publicProfile)
  self.publicProfile = _publicProfile
end

function Social:getStrResponse()
    return self.json
end
function Social:setStrResponse(_json)
    self.json = _json  
end
function Social:setResponseSuccess(_success)
    self.success = _success  
end
function Social:getResponseSuccess()
    return self.success  
end
return Social