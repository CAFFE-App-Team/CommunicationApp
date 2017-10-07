local composer = require( "composer" )
local gameData = require( "gameData" )
local loadsave = require( "loadsave" )
local barScene = require "barScene"
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local buttons={}


local iconMax=10
 local rightArrow
 local leftArrow

 local screenGrid={}

  local canPressRightArrow=true
  local canPressLeftArrow=true

  local gridX={0}
  --local gridX={0, display.contentWidth-15, 2*(display.contentWidth-15)}

 local gridDisplayed=1

 local numberOfGrids = 3
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen


gameData.isNumberScreen=false



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
          rightArrow.alpha=0.7



        end


      gameData.homeScreenGridPosition = gridDisplayed
      loadsave.saveTable (gameData.homeScreenGridPosition, "homeScreenGridPosition.json" )

     end 

  if ( event.phase == "began" ) then

      if (canPressRightArrow) then

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
          leftArrow.alpha=0.7

        end

      gameData.homeScreenGridPosition = gridDisplayed
      loadsave.saveTable (gameData.homeScreenGridPosition, "homeScreenGridPosition.json" )

     end 

    if ( event.phase == "began" ) then

if (canPressLeftArrow) then

  canPressLeftArrow=false

gridDisplayed=gridDisplayed-1

    
     for i = 1, #screenGrid do

     transition.to( screenGrid[i], { time=400, x=screenGrid[i].x+465, y=screenGrid[i].y,  onComplete=scrollComplete } )
   end


    end

  end

end

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
leftArrow.alpha=0.7
leftArrow:addEventListener( "touch", leftArrowPress )
canPressLeftArrow=false




 local function loadScreen( event )
    if ( event.phase == "began" ) then
    
        local options =
{
    effect = "crossFade",
    time = 400


}

local name = event.target.name

if (name=="homeScreen") then


--gameData.workingScreen = gameData.homeScreen
--gameData.saveFile="homeScreen"
gameData.screenIndex=1

gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 


elseif (name=="schoolScreen") then

    --gameData.workingScreen = gameData.schoolScreen
    --gameData.saveFile="schoolScreen"
    gameData.screenIndex=2

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 


elseif (name=="peopleScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=3

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 

elseif (name=="banglaNumberScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=4

    gameData.enterEditMode=true 

composer.gotoScene( "number", options ) 

elseif (name=="actionScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=5

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 

elseif (name=="emotionScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=6

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 

elseif (name=="questionScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=7

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 



elseif (name=="timeScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=8

    gameData.enterEditMode=true 

composer.gotoScene( "game", options )


elseif (name=="banglaSorbornoScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=9

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 


elseif (name=="banglaBenjorbornoScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=10

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 

 

elseif (name=="colourScreen") then

    --gameData.workingScreen = gameData.emergencyScreen
    --gameData.saveFile="emergencyScreen"
    gameData.screenIndex=11

    gameData.enterEditMode=true 

composer.gotoScene( "game", options ) 


end 

 

    end
    return true
 end  

 local size = 68
 local startX = 80
 local startY = 200
 local gap = 80   
 
 buttons[1] = display.newImageRect( "category/home.png", size,size)
 buttons[1].x = startX
 buttons[1].y = startY
 buttons[1].name = "homeScreen"
 screenGrid[1]:insert(buttons[1])

buttons[1]:addEventListener( "touch", loadScreen )


 buttons[2] = display.newImageRect("category/school.png", size,size)
 buttons[2].x = startX+gap
 buttons[2].y = startY
  buttons[2].name = "schoolScreen"
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

    buttons[7] = display.newImageRect( "category/question.png",size,size)
 buttons[7].x = startX+nextScreen+(2*gap)
 buttons[7].y = startY
  buttons[7].name = "questionScreen"
 screenGrid[2]:insert(buttons[7])
  buttons[7]:addEventListener( "touch", loadScreen )

  buttons[8] = display.newImageRect( "category/time.png",size,size)
 buttons[8].x = startX+nextScreen+(3*gap)
 buttons[8].y = startY
  buttons[8].name = "timeScreen"
 screenGrid[2]:insert(buttons[8])
  buttons[8]:addEventListener( "touch", loadScreen )

  nextScreen = 465*2

 buttons[9] = display.newImageRect( "category/bengalilLettersShorborno.png",size,size)
 --buttons[9].alpha=0.6
 buttons[9].x = startX+nextScreen+gap
 buttons[9].y = startY
 buttons[9].name = "banglaSorbornoScreen"
 screenGrid[3]:insert(buttons[9])
 buttons[9]:addEventListener( "touch", loadScreen )


 buttons[10] = display.newImageRect( "category/bengalilLettersBenjonborno.png",size,size)
 --buttons[10].alpha=0.6
 buttons[10].x = startX+nextScreen+(2*gap)
 buttons[10].y = startY
 buttons[10].name = "banglaBenjorbornoScreen"
 screenGrid[3]:insert(buttons[10])
 buttons[10]:addEventListener( "touch", loadScreen )
  

 buttons[11] = display.newImageRect( "category/colours.png",size,size)
 buttons[11].x = startX+nextScreen+(3*gap)
 buttons[11].y = startY
 buttons[11].name = "colourScreen"
 screenGrid[3]:insert(buttons[11])
 buttons[11]:addEventListener( "touch", loadScreen )

print ("grids is "..numberOfGrids)

for addGrids = 1, numberOfGrids do
  sceneGroup:insert(screenGrid[addGrids])
end


if (gameData.homeScreenGridPosition > 1) then

  for setUp=1, #screenGrid do

  screenGrid[setUp].x = screenGrid[setUp].x-(465* (gameData.homeScreenGridPosition -1) )

  end
end  




gridDisplayed = gameData.homeScreenGridPosition

        if (gridDisplayed < numberOfGrids) then

          canPressRightArrow=true
          rightArrow.alpha=1


        else

          canPressRightArrow=false
          rightArrow.alpha=0.7

        end

        if (gridDisplayed>1) then

          canPressLeftArrow=true
          leftArrow.alpha=1

        else

          canPressLeftArrow=false
          leftArrow.alpha=0.7

        end

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

   if (gameData.firstRun==true) then
   createBar()
   gameData.firstRun=false
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