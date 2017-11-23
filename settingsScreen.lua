local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )
local loadsave = require( "loadsave" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 


-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local phase = event.phase

    local sceneGroup = self.view
   

local function closeSettingsView( event )
 
      if ( event.phase == "began" ) then

        composer.hideOverlay( "fade", 400 )

        parent:resetTopBar()

        scene:addEventListener( "hide", scene )


    end

    return true

end


local function sizeSelect( event )
 
      if ( event.phase == "began" ) then

        iconBtn1.alpha=0.5
        iconBtn2.alpha=0.5
        iconBtn3.alpha=0.5
        iconBtn4.alpha=0.5
        event.target.alpha=1

        print(event.target.id);
        gameData.size=event.target.id;
        loadsave.saveTable (gameData.size, "gridSize.json" )

      end

return true

end


settingsBg = display.newImageRect("settingsBg.png", 370, 200)
settingsBg.x = display.contentCenterX-35
settingsBg.y = display.contentCenterY
settingsBg.alpha=0.95
sceneGroup:insert(settingsBg)


iconBtn1 = display.newImageRect("icons3.png", 80, 46)
iconBtn1.x = display.contentCenterX-130
iconBtn1.y = display.contentCenterY-50
iconBtn1.id="vl"
iconBtn1:addEventListener( "touch", sizeSelect )
if (gameData.size==iconBtn1.id) then
iconBtn1.alpha=1
    else
iconBtn1.alpha=0.5
end
sceneGroup:insert(iconBtn1)

iconBtn2 = display.newImageRect("icons6.png", 80, 46)
iconBtn2.x = display.contentCenterX
iconBtn2.y = display.contentCenterY-50
iconBtn2.id="l"
iconBtn2:addEventListener( "touch", sizeSelect )
if (gameData.size==iconBtn2.id) then
iconBtn2.alpha=1
    else
iconBtn2.alpha=0.5
end
sceneGroup:insert(iconBtn2)

iconBtn3 = display.newImageRect("icons8.png", 80, 46)
iconBtn3.x = display.contentCenterX-130
iconBtn3.y = display.contentCenterY+25
iconBtn3.id="m"
iconBtn3:addEventListener( "touch", sizeSelect )
if (gameData.size==iconBtn3.id) then
iconBtn3.alpha=1
    else
iconBtn3.alpha=0.5
end
sceneGroup:insert(iconBtn3)

iconBtn4 = display.newImageRect("icons10.png", 80, 46)
iconBtn4.x = display.contentCenterX
iconBtn4.y = display.contentCenterY+25
iconBtn4.id="s"
iconBtn4:addEventListener( "touch", sizeSelect )
if (gameData.size==iconBtn4.id) then
iconBtn4.alpha=1
    else
iconBtn4.alpha=0.5
end
sceneGroup:insert(iconBtn4)


okBtn = display.newImageRect("okTextBtn.png", 35*2.58,35)
okBtn.name = "ok"
okBtn.x = display.contentCenterX +90
okBtn.y = display.contentCenterY + 70
sceneGroup:insert(okBtn)

okBtn:addEventListener("touch", closeSettingsView)
 

end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
      print (event.parent)

      parent=event.parent

    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
       
 
    end
end
 
 
-- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    local parent = event.parent  -- Reference to the parent scene object
 
    if ( phase == "will" ) then
        -- Call the "resumeGame()" function in the parent scene

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