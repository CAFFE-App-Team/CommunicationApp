
local widget = require('widget')
local dropdown = require('dropdown')
local screen = require('screen')
local App42API = require("App42-Lua-API.App42API") 
local usageData = require ("usageData")
local loadsave = require( "loadsave" ) 
local gameData = require( "gameData" )
local timeData = require( "timeData" )
local cardData = require ("cardData")
local studentUsers = require( "studentUsers" )

local JSON = require("App42-Lua-API.JSON")
local coronaJson = require( "json" )


local composer = require( "composer" )
 
local scene = composer.newScene()
 
local myDropdown
-- create()
function scene:create( event )
 
    local sceneGroup = self.view

       --download cardData

       local function uploadCardDataFirstTime()

        local dbName  = "WORDFREQUENCY"
        local collectionName = "wordStats"
        local jsonTable = {}
        jsonTable = JSON:encode(cardData)
        local App42CallBack = {}
        App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
        local storageService = App42API:buildStorageService()
        storageService:insertJSONDocument(dbName, collectionName, jsonTable ,App42CallBack)
        function App42CallBack:onSuccess(object)
          print ("setup first")
          composer.gotoScene("mainMenu")
        end
        function App42CallBack:onException(exception)
            print("Message is : "..exception:getMessage())
            print("App Error code is : "..exception:getAppErrorCode())
            print("Http Error code is "..exception:getHttpErrorCode())
            print("Detail is : "..exception:getDetails())
        end




       end 

       local function downloadDefault()

        local dbName  = "WORDFREQUENCY"
            local collectionName = "wordStats"
            local key = "studentName"
            local value = "default"
            local App42CallBack = {}
            App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
            local storageService = App42API:buildStorageService()
            storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("dbName is "..object:getDbName())
                for i=1,table.getn(object:getJsonDocList()) do
                    print("DocId is "..object:getJsonDocList()[i]:getDocId())
                    gameData.cardDocID = object:getJsonDocList()[i]:getDocId()

                    print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
                end

                print ('download card data from default')
              
                 jsonCardData = JSON:encode(object:getJsonDocList()[1]:getJsonDoc())  
                 
                 cardData = coronaJson.decode(jsonCardData)

                  for top=1, #cardData.topics do

                 local jCopy = coronaJson.encode(cardData.topics[top])

                  gameData.topics[top] = coronaJson.decode(jCopy)

                end


                    for i = 1, #gameData.topics do

                    table.insert( gameData.mainMenuItems, gameData.topics[i][1].text   )
                    table.insert (gameData.pictureScale, gameData.topics[i][1].ind)

                      print ("login")
                      print (gameData.mainMenuItems[i].."  "..gameData.pictureScale[i])

                    table.remove( gameData.topics[i], 1)

                    end

                    cardData.studentName=gameData.studentName
                    loadsave.saveTable (gameData.studentName, "studentName.json" )
                    loadsave.saveTable (cardData.topics, "cardDataTopics.json" )

                    uploadCardDataFirstTime()
            end
            function App42CallBack:onException(exception)
                print("Message is : "..exception:getMessage())
                print("App Error code is : "..exception:getAppErrorCode())
                print("Http Error code is "..exception:getHttpErrorCode())
                print("Detail is : "..exception:getDetails())
            end


      end




       local function getCardData()

        print ('getting data')

          local dbName  = "WORDFREQUENCY"
            local collectionName = "wordStats"
            local key = "studentName"
            local value = gameData.studentName
            local App42CallBack = {}
            App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
            local storageService = App42API:buildStorageService()
            storageService:findDocumentByKeyValue(dbName, collectionName,key,value,App42CallBack)
            function App42CallBack:onSuccess(object)
                print("dbName is "..object:getDbName())
                for i=1,table.getn(object:getJsonDocList()) do
                    print("DocId is "..object:getJsonDocList()[i]:getDocId())
                    gameData.cardDocID = object:getJsonDocList()[i]:getDocId()

                    print("CreatedAt is "..object:getJsonDocList()[i]:getCreatedAt())
                end

                print ('download card data ')
              
                 jsonCardData = JSON:encode(object:getJsonDocList()[1]:getJsonDoc())  
                 
                 cardData = coronaJson.decode(jsonCardData)

                  for top=1, #cardData.topics do

                 local jCopy = coronaJson.encode(cardData.topics[top])

                  gameData.topics[top] = coronaJson.decode(jCopy)

                end


                    for i = 1, #gameData.topics do

                    table.insert( gameData.mainMenuItems, gameData.topics[i][1].text   )

                    table.insert (gameData.pictureScale, gameData.topics[i][1].ind)

                      print ("login")
                      print (gameData.mainMenuItems[i].."  "..gameData.pictureScale[i])

                    table.remove( gameData.topics[i], 1)

                    end

                    loadsave.saveTable (gameData.studentName, "studentName.json" )
                    loadsave.saveTable (cardData.topics, "cardDataTopics.json" )

                 composer.gotoScene("mainMenu")
            end
            function App42CallBack:onException(exception)
                print("Message is : "..exception:getMessage())
                print("App Error code is : "..exception:getAppErrorCode())
                print("Http Error code is "..exception:getHttpErrorCode())
                print("Detail is : "..exception:getDetails())
                downloadDefault()
            end

      end

local  dropdownOptions = {}  

 print ('dd names '..studentUsers.names[1]) 

for i=1, #studentUsers.names do

  print ('dd names '..studentUsers.names[i])

    table.insert( dropdownOptions,  { title=studentUsers.names[i], 
          action    = function()
          gameData.studentName = studentUsers.names[i] 
          getCardData()
          end  }  );


end

--[[local dropdownOptions = {
  {
    title     = 'setu',
    action    = function()
    gameData.studentName = "kobir" 
     getCardData()
    end 
  },
  {
    title     = 'fahim',
    action    = function() 
    gameData.studentName = title 
     getCardData()
    end 
  },
  {

    title     = 'kobir',
    action    = function() 
    gameData.studentName = title 
     getCardData()
    end 
  },
    {

    title     = 'roksana',
    action    = function() 
    gameData.studentName = title 
     getCardData()
    end 
  },
    {

    title     = 'Kobir',
    action    = function() 
    gameData.studentName = title 
     getCardData()
    end 
  },
    {

    title     = 'Roksana',
    action    = function() 
    gameData.studentName = title 
     getCardData()
    end 
  },
   
}--]]

local button = widget.newButton{
  width       = 32,
  height      = 32,
  defaultFile = 'arrow.png',
  overFile    = 'arrow.png',
  onEvent     = function( event )
    local target = event.target
    local phase  = event.phase
    if phase == 'began' then
      target.alpha = .5
    else
      target.alpha = 1
      if phase ==  'ended' then
       -- myDropdown:toggle()
      end
    end
  end
}
button.alpha = 0

myDropdown     = dropdown.new{
  x            = screen.rightSide - 100,
  y            = screen.topSide,
  toggleButton = button,
  width        = 280,
  marginTop    = 12,
  padding      = 10,
  options      = dropdownOptions
}

myDropdown:toggle()

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene



