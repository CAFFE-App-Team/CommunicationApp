local composer = require( "composer" )
local gameData = require( "gameData" )
local loadsave = require( "loadsave" )
local barScene = require "barScene"
local usageData = require "usageData"
local gameData = require( "gameData" )
local timeData = require( "timeData" )
local cardData = require( "cardData" )
local studentUsers = require( "studentUsers" )
 
local JSON = require("App42-Lua-API.JSON")
local App42API = require("App42-Lua-API.App42API") 
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 display.setStatusBar( display.HiddenStatusBar )
 local buttons={}

local iconMax=10
 local rightArrow
 local leftArrow

 local screenGrid={}

 local dataBtnCount=0

  local canPressRightArrow=true
  local canPressLeftArrow=true

  local gridX={0}
  --local gridX={0, display.contentWidth-15, 2*(display.contentWidth-15)}

 local gridDisplayed=1

 local numberOfGrids = 4

 local canTouch=true
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


gameData.isNumberScreen=false
gameData.workingScreen=nil

 if (loadsave.loadTable( "classMode.json") ~= nil) then
gameData.classMode = loadsave.loadTable( "classMode.json")
end

 if (loadsave.loadTable( "timeData.json") ~= nil) then
usageData.timeData = loadsave.loadTable( "timeData.json")
end

 if (loadsave.loadTable( "gridSize.json") ~= nil) then
gameData.size = loadsave.loadTable( "gridSize.json")
end

 if (loadsave.loadTable( "studentName.json") ~= nil) then
gameData.studentName = loadsave.loadTable( "studentName.json")
cardData.studentName = loadsave.loadTable( "studentName.json")
end


usageData.sampleData[1].text=gameData.studentName

print ("main menu samp data "..usageData.sampleData[1].text)

if (gameData.size==nil) then
  gameData.size="m"
 end 


  if (gameData.size=="s") then

     iconMax=10

  elseif (gameData.size=="m") then

   iconMax=8


    elseif (gameData.size=="l") then

   iconMax=6

    end



      if (loadsave.loadTable( "screenGridPositions.json" ) ~= nil) then
      gameData.screenGridPositions = loadsave.loadTable( "screenGridPositions.json")
      end

      if (loadsave.loadTable( "homeScreenGridPosition.json" ) ~= nil) then
      gameData.homeScreenGridPosition = loadsave.loadTable( "homeScreenGridPosition.json")
      end

--[[      if (loadsave.loadTable( "sampleData.json" ) ~= nil) then
      usageData.sampleData = loadsave.loadTable( "sampleData.json")
      end

    if (loadsave.loadTable( "sentenceData.json" ) ~= nil) then
      usageData.sentences = loadsave.loadTable( "sentenceData.json")
      end--]]
   

--[[    local bg = display.newImageRect ("whiteBG.png", display.contentWidth, display.contentHeight)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)--]]


for screenGridCount = 1, numberOfGrids do

    screenGrid[screenGridCount] = display.newGroup()

end




 local function rightArrowPress( event )

      local function scrollComplete(obj)

          canPressLeftArrow=true
          leftArrow.alpha=1

        if (gridDisplayed < numberOfGrids) then

          canPressRightArrow=true
          rightArrow.alpha=1


        else

          canPressRightArrow=false
          rightArrow.alpha=0.2



        end


      gameData.homeScreenGridPosition = gridDisplayed
      loadsave.saveTable (gameData.homeScreenGridPosition, "homeScreenGridPosition.json" )

      canTouch=true

     end 

  if ( event.phase == "began" ) then

      if (canPressRightArrow and canTouch) then

      canTouch=false  

      canPressRightArrow=false

      gridDisplayed=gridDisplayed+1
  
     --screenGrid[2].x =-520

     for i = 1, #screenGrid do

     transition.to( screenGrid[i], { time=400, x=screenGrid[i].x-465, y=screenGrid[i].y, onComplete=scrollComplete } )
   end

    end

  end

end

  local function leftArrowPress( event )

      local function scrollComplete(obj)

          canPressRightArrow=true
          rightArrow.alpha=1

        if (gridDisplayed>1) then

          canPressLeftArrow=true
          leftArrow.alpha=1

        else

          canPressLeftArrow=false
          leftArrow.alpha=0.2

        end

      gameData.homeScreenGridPosition = gridDisplayed
      loadsave.saveTable (gameData.homeScreenGridPosition, "homeScreenGridPosition.json" )

      canTouch=true

     end 

    if ( event.phase == "began" ) then

if (canPressLeftArrow and canTouch) then

  canTouch=false

  canPressLeftArrow=false

gridDisplayed=gridDisplayed-1

    
     for i = 1, #screenGrid do

     transition.to( screenGrid[i], { time=400, x=screenGrid[i].x+465, y=screenGrid[i].y,  onComplete=scrollComplete } )
   end


    end

  end

end






 local function loadScreen( event )
    if ( event.phase == "began" ) then

      if (canTouch) then
    
        local options =
{
    effect = "crossFade",
    time = 400


}

--local name = event.target.name

gameData.selectedCardIndex = event.target.index

--[[for match = 1, #gameData.screenList do
  if (gameData.screenList[match].name == name) then
    gameData.screenIndex=match
  end
end--]]

if (gameData.selectedCardIndex == 2 or gameData.selectedCardIndex == 3) then

    gameData.enterEditMode=true 

    composer.gotoScene( "number", options ) 

    -- do number page

  else

    gameData.enterEditMode=true 

    composer.gotoScene( "game", options ) 

  end

 

    end

  end
    return true
 end  

 local size = 68
 local startX = 80
 local startY = 200
 local gap = 80
 local nextScreen = 0 
 local gridCount=1  
 

 for buttonCount = 1, #gameData.mainMenuItems do

  buttons[buttonCount] = display.newImageRect ("category/"..gameData.mainMenuItems[buttonCount]..".png", size, size)
  buttons[buttonCount].x = startX
  buttons[buttonCount].y = startY
  buttons[buttonCount].index = buttonCount



  screenGrid[gridCount]:insert(buttons[buttonCount])
  buttons[buttonCount]:addEventListener("touch", loadScreen)

  startX = startX + gap



 if (buttonCount % 4 == 0) then
  print ('new screen')
  nextScreen = nextScreen + 465
    startX = nextScreen+80
    
    gap = 80
    gridCount=gridCount+1

  end

 end 
 
--[[ buttons[1] = display.newImageRect( "category/school.png", size,size)
 buttons[1].x = startX
 buttons[1].y = startY
 buttons[1].name = "amarJotiNoti"
 buttons[1].index = 7
 screenGrid[1]:insert(buttons[1])

buttons[1]:addEventListener( "touch", loadScreen )


 buttons[2] = display.newImageRect("category/toys.png", size,size)
 buttons[2].x = startX+gap
 buttons[2].y = startY
  buttons[2].name = "toysScreen"
 screenGrid[1]:insert(buttons[2])
  buttons[2]:addEventListener( "touch", loadScreen )

 buttons[3] = display.newImageRect( "category/people.png",size,size)
 buttons[3].x = startX+(2*gap)
 buttons[3].y = startY
  buttons[3].name = "peopleScreen"
 screenGrid[1]:insert(buttons[3])
  buttons[3]:addEventListener( "touch", loadScreen )



 buttons[4] = display.newImageRect( "category/bengaliNumbers.png",size,size)
 buttons[4].x = startX+(3*gap)
 buttons[4].y = startY
 buttons[4].name = "banglaNumberScreen"
 screenGrid[1]:insert(buttons[4])
 buttons[4]:addEventListener( "touch", loadScreen )

    local nextScreen = 465

 buttons[5] = display.newImageRect( "category/action.png",size,size)
 buttons[5].x = startX+nextScreen
 buttons[5].y = startY
 buttons[5].name = "actionScreen"
 screenGrid[2]:insert(buttons[5])
 buttons[5]:addEventListener( "touch", loadScreen )

 buttons[6] = display.newImageRect( "category/emotion.png",size,size)
 buttons[6].x = startX+nextScreen+gap
 buttons[6].y = startY
 buttons[6].name = "emotionScreen"
 screenGrid[2]:insert(buttons[6])
 buttons[6]:addEventListener( "touch", loadScreen )

 buttons[7] = display.newImageRect( "category/bengalilLettersShorborno.png",size,size)
 buttons[7].x = startX+nextScreen+(2*gap)
 buttons[7].y = startY
 buttons[7].name = "banglaSorbornoScreen"
 screenGrid[2]:insert(buttons[7])
 buttons[7]:addEventListener( "touch", loadScreen )

 buttons[8] = display.newImageRect( "category/bengalilLettersBenjonborno.png",size,size)
 buttons[8].x = startX+nextScreen+(3*gap)
 buttons[8].y = startY
 buttons[8].name = "banglaBenjorbornoScreen"
 screenGrid[2]:insert(buttons[8])
 buttons[8]:addEventListener( "touch", loadScreen )

  nextScreen = 465*2

 buttons[9] = display.newImageRect( "category/colours.png",size,size)
 --buttons[9].alpha=0.6
 buttons[9].x = startX+nextScreen
 buttons[9].y = startY
 buttons[9].name = "colourScreen"
 screenGrid[3]:insert(buttons[9])
 buttons[9]:addEventListener( "touch", loadScreen )


 buttons[10] = display.newImageRect( "category/englishLetters.png",size,size)
 --buttons[10].alpha=0.6
 buttons[10].x = startX+nextScreen+(1*gap)
 buttons[10].y = startY
 buttons[10].name = "englishLetterScreen"
 screenGrid[3]:insert(buttons[10])
 buttons[10]:addEventListener( "touch", loadScreen )
  

 buttons[11] = display.newImageRect( "category/englishNumbers.png",size,size)
 buttons[11].x = startX+nextScreen+(2*gap)
 buttons[11].y = startY
 buttons[11].name = "englishNumberScreen"
 screenGrid[3]:insert(buttons[11])
 buttons[11]:addEventListener( "touch", loadScreen )--]]


 -- buttons[12] = display.newImageRect( "category/colours.png",size,size)
 -- buttons[12].x = startX+nextScreen+(3*gap)
 -- buttons[12].y = startY
 -- buttons[12].name = "foodScreen"
 -- screenGrid[3]:insert(buttons[12])
 -- buttons[12]:addEventListener( "touch", loadScreen )

-- nextScreen = 465*3

--[[ buttons[12] = display.newImageRect( "category/common.png",size,size)
 buttons[12].x = startX+nextScreen+(3*gap)
 buttons[12].y = startY
 buttons[12].name = "commonScreen"
 screenGrid[3]:insert(buttons[12])
 buttons[12]:addEventListener( "touch", loadScreen )
 
 nextScreen = 465*3

 buttons[13] = display.newImageRect( "category/stories.png",size,size)
 buttons[13].x = startX+nextScreen
 buttons[13].y = startY
 buttons[13].name = "storyScreen"
 screenGrid[4]:insert(buttons[13])
 buttons[13]:addEventListener( "touch", loadScreen )--]]

--[[  buttons[13] = display.newImageRect( "category/stories.png",size,size)
 buttons[13].x = startX+nextScreen+(3*gap*2)
 buttons[13].y = startY
 buttons[13].name = "storiesScreen"
 screenGrid[4]:insert(buttons[13])
 buttons[13]:addEventListener( "touch", loadScreen )--]]



for addGrids = 1, numberOfGrids do
  sceneGroup:insert(screenGrid[addGrids])
end


if (gameData.homeScreenGridPosition > 1) then

  for setUp=1, #screenGrid do

  screenGrid[setUp].x = screenGrid[setUp].x-(465* (gameData.homeScreenGridPosition -1) )

  end
end  


local leftRectangle = display.newRect( 0, 100, 70, 400 )
leftRectangle:setFillColor( 69/255, 39/255, 160/255 )
sceneGroup:insert(leftRectangle)

local rightRectangle = display.newRect( 428, 100, 105, 400 )
rightRectangle:setFillColor( 69/255, 39/255, 160/255 )
sceneGroup:insert(rightRectangle)


local arrowWidth=30
local arrowHeight=arrowWidth*3.566


rightArrow = display.newImageRect( "rightArrow.png",arrowWidth,arrowHeight)
sceneGroup:insert(rightArrow)
rightArrow.x=390
rightArrow.y=200
rightArrow:addEventListener( "touch", rightArrowPress )

leftArrow = display.newImageRect( "leftArrow.png",arrowWidth,arrowHeight)
sceneGroup:insert(leftArrow)
leftArrow.x=20
leftArrow.y=200
leftArrow.alpha=0.2
leftArrow:addEventListener( "touch", leftArrowPress )
canPressLeftArrow=false



gridDisplayed = gameData.homeScreenGridPosition

        if (gridDisplayed < numberOfGrids) then

          canPressRightArrow=true
          rightArrow.alpha=1


        else

          canPressRightArrow=false
          rightArrow.alpha=0.2

        end

        if (gridDisplayed>1) then

          canPressLeftArrow=true
          leftArrow.alpha=1

        else

          canPressLeftArrow=false
          leftArrow.alpha=0.2

        end



          function scene:resetTopBar()

insertToScene(sceneGroup)

 end 



    local function enterSettings(event)

            if ( event.phase == "began" ) then


       insertToScene(sceneGroup)

      local options =
{
     isModal = true,
    effect = "crossFade",
    time = 400,

}

composer.showOverlay( "settingsScreen", options )


end

return true


    end




local function longPressUpdate()

  local timeHeld = os.time() - pressTimer
  if (timeHeld >= 2 and canFire) then
    canFire=false
  print("Held for 2 sec or longer, do something")
  enterSettings()
   end 

end  

    
    local function handleButtonEvent( event )
        local phase = event.phase
        if "began" == phase then
             pressTimer = os.time()
             canFire=true
             pressRuntimer = timer.performWithDelay(1, longPressUpdate, -1)
        elseif "ended" == phase then
             local timeHeld = os.time() - pressTimer
             if timeHeld >= 2 then
                timer.cancel(pressRuntimer)
             else
                  print("Held short, do something")
                  timer.cancel(pressRuntimer)
             end
        end
    end


local settingsBtn = display.newImageRect( "settings.png", 20,20)
settingsBtn.x=display.contentWidth-35
settingsBtn.y=265

sceneGroup:insert(settingsBtn)

settingsBtn:addEventListener("touch", enterSettings)


local commonBtn = display.newImageRect( "category/common.png", 50,50)
commonBtn.x=display.contentWidth-35
commonBtn.y=220
commonBtn.index = 1
sceneGroup:insert(commonBtn)

commonBtn:addEventListener( "touch", loadScreen )



 local function loadDataScreen( event )

    if ( event.phase == "began" ) then

  if (canTouch) then

    dataBtnCount = dataBtnCount + 1

    if (dataBtnCount > 9) then
    
    local options =
    {
    effect = "crossFade",
    time = 400

    }
    composer.gotoScene( "usageTable", options ) 

  end

end
  
  end
    return true
 end 


local dataBtn = display.newImageRect( "dataBtnInvisi.png", 25,25)
dataBtn.x=30
dataBtn.y=270
dataBtn.alpha=0.5

sceneGroup:insert(dataBtn)

dataBtn:addEventListener( "touch", loadDataScreen )


--remp studd here

function sendDataManual(event)

   if ( event.phase == "began" ) then

     local t = os.date( '*t' )

    local seconds =  os.time( t ) - gameData.startTime

      local minutesLeft = seconds / 60
      local myHours = round (minutesLeft / 60)
      local myMinutes = round (minutesLeft - (myHours*60))
       

      table.insert( usageData.timeData,  { date=os.date( "%c" ), hours=myHours, minutes=myMinutes }  )


    loadsave.saveTable (usageData.timeData, "timeData.json" )

local function setUpTable() 

local dbName  = "WORDFREQUENCY"
local collectionName = "wordStats"
local jsonTable = {}
jsonTable = JSON:encode(usageData)
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local storageService = App42API:buildStorageService()
storageService:insertJSONDocument(dbName, collectionName, jsonTable ,App42CallBack)
function App42CallBack:onSuccess(object)
  print ("setup first")

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
end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())
end


end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())
end


end    

if (gameData.studentName~="none") then


local dbName  = "WORDFREQUENCY"
local collectionName = "wordStats"
local key = "sampleData.text"
local value = gameData.studentName
print ("value is "..gameData.studentName)
local jsonTable = {}
jsonTable = JSON:encode(usageData)
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local storageService = App42API:buildStorageService()
storageService:updateDocumentByKeyValue(dbName,collectionName,key,value,jsonTable,App42CallBack)
function App42CallBack:onSuccess(object)
    print ("UPDATED")
    local dbName  = "WORDFREQUENCY"
    local collectionName = "wordStats"
    local key = "studentName"
    local value = gameData.studentName
    print ("value is "..gameData.studentName)
    local jsonTable = {}
    jsonTable = JSON:encode(cardData)
    local App42CallBack = {}
    App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
    local storageService = App42API:buildStorageService()
    storageService:updateDocumentByKeyValue(dbName,collectionName,key,value,jsonTable,App42CallBack)
    function App42CallBack:onSuccess(object)
        print ("UPDATED")
    end
    function App42CallBack:onException(exception)
        print("Message is : "..exception:getMessage())
        print("App Error code is : "..exception:getAppErrorCode())
        print("Http Error code is "..exception:getHttpErrorCode())
        print("Detail is : "..exception:getDetails())

    end


end
function App42CallBack:onException(exception)
    print("Message is : "..exception:getMessage())
    print("App Error code is : "..exception:getAppErrorCode())
    print("Http Error code is "..exception:getHttpErrorCode())
    print("Detail is : "..exception:getDetails())

    setUpTable();

end

end

end

end


local function sendNames(event)

 if ( event.phase == "began" ) then

print ('sender')

local dbName  = "WORDFREQUENCY"
local collectionName = "wordStats"
local jsonTable = {}
jsonTable = JSON:encode(studentUsers)
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local storageService = App42API:buildStorageService()
storageService:insertJSONDocument(dbName, collectionName, jsonTable ,App42CallBack)
function App42CallBack:onSuccess(object)
  print ("setup first")
end

function App42CallBack:onException(exception)

end

end

return true

end

local function getImage()

  local function beginFileDownload(myUrl, myFile,fileType)

    local function networkListener( event )
    if ( event.isError ) then
        print( "Network error - download failed: ", event.response )
    elseif ( event.phase == "began" ) then
        print( "Progress Phase: began" )
    elseif ( event.phase == "ended" ) then
        print( "Displaying response image file" )
--[[        myImage = display.newImage( event.response.filename, event.response.baseDirectory, 60, 40 )
        myImage.alpha = 0
        transition.to( myImage, { alpha=1.0 } )--]]
    end
end


 
local params = {}
params.progress = true
 
network.download(
    myUrl,
    "GET",
    networkListener,
    params,
    fileType.."/"..myFile,
    system.DocumentsDirectory
)

  end  


local userName = gameData.studentName;
local App42CallBack = {}
App42API:initialize("e1ab95c1cd21bd9d5e45fda6ac6fac73a233425f14d7c32beee1671a13a18174","dab972571a4b1f0c02fb34620ebfecc232a29fef2ccedac52c1e1d269d2a223c")
local uploadService  = App42API:buildUploadService()
uploadService:getAllFilesByUser(userName,App42CallBack)
function App42CallBack:onSuccess(object)  
  if table.getn(object:getFileList()) >1 then   
  for m=1,table.getn(object:getFileList()) do  
 
    if (object:getFileList()[m]:getType()=="UploadFileType.AUDIO") then
      local myType = "sounds"
      beginFileDownload (object:getFileList()[m]:getUrl(), object:getFileList()[m]:getName(), myType )

      elseif (object:getFileList()[m]:getType() == "UploadFileType.IMAGE") then
              local myType = "images"
      beginFileDownload (object:getFileList()[m]:getUrl(), object:getFileList()[m]:getName(), myType )

      end

    print("fileName is :".. object:getFileList()[m]:getName()); 
    print("Username is :".. object:getFileList()[m]:getUserName()); 
    print("Type is :".. object:getFileList()[m]:getType());     
    print("Url is :".. object:getFileList()[m]:getUrl());  
    print("Description is: ".. object:getFileList()[m]:getDescription());  
  end
  else     
    print("fileName is :".. object:getFileList():getName());
    print("Username is :".. object:getFileList():getUserName());  
    print("Type is :".. object:getFileList():getType());     
    print("Url is :".. object:getFileList():getUrl());  
    print("fileDescription is: ".. object:getFileList():getDescription());  
  end
end  
function App42CallBack:onException(exception)
  print("Message is : "..exception:getMessage())
  print("App Error code is : "..exception:getAppErrorCode())
  print("Http Error code is "..exception:getHttpErrorCode())
  print("Detail is : "..exception:getDetails())
end


end


--[[local sendBtn = display.newImageRect( "dataBtnInvisi.png", 25,25)
sendBtn.x=200
sendBtn.y=270
sendBtn.alpha=1

sceneGroup:insert(sendBtn)--]]

--sendBtn:addEventListener( "touch", sendDataManual)

--sendBtn:addEventListener( "touch", getImage)



end

 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
   composer.removeScene( "game")
   composer.removeScene( "number")
   composer.removeScene("settingsScreen")
   composer.removeScene( "usageTable")



   if (gameData.firstRun==true) then
    print ('CREATE BAR')
   createBar()
   gameData.firstRun=false

else

  barScrollView.alpha=1
  readBtn.alpha=1
deleteBtn.alpha=1
topSquare.alpha=1

end
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