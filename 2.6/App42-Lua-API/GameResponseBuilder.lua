--author Himanshu Sharma
local App42ResponseBuilder = require("App42-Lua-API.App42ResponseBuilder")
local JSON = require("App42-Lua-API.JSON")
local Game = require("App42-Lua-API.Game")
local Score = require("App42-Lua-API.Score")
local FacebookProfile =require("App42-Lua-API.FacebookProfile")
local StorageResponseBuilder = require("App42-Lua-API.StorageResponseBuilder")
local GameResponseBuilder = {}

function GameResponseBuilder:buildResponse(json)
  local game = require("App42-Lua-API.Game")
  local gamesJSONObj = App42ResponseBuilder:getServiceJSONObject("games",json)
    if(gamesJSONObj == nil) then 
      game:setStrResponse(json)
      game:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
      game:setTotalRecords(App42ResponseBuilder:getTotalRecords(json))
    else 
      local gameJSONObject = gamesJSONObj.game
      game = GameResponseBuilder:buildGameObject(gameJSONObject)
      game:setStrResponse(json)
      game:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(json))
    end
  return game
end
function GameResponseBuilder:buildArrayResponse(responseString)
  local game = require("App42-Lua-API.Game")
  local gameJSONArray = {}
  local gamesJSONObj = App42ResponseBuilder:getServiceJSONObject("games",responseString)
  local gameJSONObjectArray = gamesJSONObj.game
  if table.getn(gameJSONObjectArray) > 0 then
    for i=1, table.getn(gameJSONObjectArray) do
      game = GameResponseBuilder:buildGameObject(gameJSONObjectArray[i])
      game:setStrResponse(responseString)
      game:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
      gameJSONArray[i] = game
    end    
  else
    game = GameResponseBuilder:buildGameObject(gameJSONObjectArray)
    game:setStrResponse(responseString)
    game:setResponseSuccess(App42ResponseBuilder:isResponseSuccess(responseString))
    gameJSONArray = game
  end
  return gameJSONArray
end
function GameResponseBuilder:buildGameObject(jsonObject)
  local score = {}
  local facebookProfile ={}
  local game = GameResponseBuilder:buildObjectFromJSONTree(jsonObject)
  if jsonObject.scores ~= nil then 
    local scoresJSONObject  = jsonObject.scores
    local scoreJSONArray = scoresJSONObject.score
    if table.getn(scoreJSONArray) > 0 then
    for i=1, table.getn(scoreJSONArray) do
      score[i] = GameResponseBuilder:buildScoreObjectFromJSONTree(scoreJSONArray[i])
      if scoreJSONArray[i].facebookProfile ~=nil then 
        facebookProfile = GameResponseBuilder:buildFaceFookObjectFromJSONTree(scoreJSONArray[i].facebookProfile)
        score[i]:setFacebookProfile(facebookProfile)
      end
      if scoreJSONArray[i].jsonDoc ~= nil then
      local documentObject = {}
        local jsonDocArray = scoreJSONArray[i].jsonDoc
         if table.getn(jsonDocArray) > 0 then
          for l=1, table.getn(jsonDocArray) do
            documentObject[l] = StorageResponseBuilder:buildJsonDocument(jsonDocArray[l])
          end 
        end
        score[i]:setJsonDocList(documentObject)
      end
    end
        game:setScoreList(score)
    else
      local documentObjectArray = {}
        score = GameResponseBuilder:buildScoreObjectFromJSONTree(scoreJSONArray)
        if scoreJSONArray.facebookProfile ~=nil then 
            facebookProfile = GameResponseBuilder:buildFaceFookObjectFromJSONTree(scoreJSONArray.facebookProfile)
            score:setFacebookProfile(facebookProfile)
        end
        if scoreJSONArray.jsonDoc ~= nil then
          local jsonDocObject = scoreJSONArray.jsonDoc
           if table.getn(jsonDocObject) > 0 then
            for k=1, table.getn(jsonDocObject) do
              documentObjectArray[k] = StorageResponseBuilder:buildJsonDocument(jsonDocObject[k])
            end 
          else
              documentObjectArray = StorageResponseBuilder:buildJsonDocument(jsonDocObject)
          end
        score:setJsonDocList(documentObjectArray)
      end
    game:setScoreList(score)
  end
end
  return game
end
function GameResponseBuilder:buildFaceFookObjectFromJSONTree(json)
  local facebookProfile = FacebookProfile:new()
  if json.name ~= nil then
    facebookProfile:setName(json.name)
  end
  if json.id ~= nil then
    facebookProfile:setId(json.id)
  end
  if json.picture ~= nil then
    facebookProfile:setPicture(json.picture)
  end
  return facebookProfile
end
function GameResponseBuilder:buildScoreObjectFromJSONTree(json)
  local score = Score:new()
  if json.userName ~= nil then
    score:setUserName(json.userName)
  end
  if json.value ~= nil then
    score:setValue(json.value)
  end
  if json.scoreId ~= nil then
    score:setScoreId(json.scoreId)
  end
  if json.createdOn ~= nil then
    score:setCreatedOn(json.createdOn)
  end
  return score
end
function GameResponseBuilder:buildObjectFromJSONTree(json)
  local gameObj = Game:new()
  if json.name ~= nil then
    gameObj:setName(json.name)
  end
  if json.description ~= nil then
    gameObj:setDescription(json.description)
  end
  return gameObj;
end
return GameResponseBuilder