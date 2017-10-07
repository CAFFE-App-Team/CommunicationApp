local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local imageBoxes={}
  local backBoxes={}
 local labelBox
 local okBtn

 local startLabelText
 local parent
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local phase = event.phase


 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 -- ScrollView listener



 startLabelText = gameData.workingScreen[gameData.indexEdit].text

 local imageGroup = display.newGroup()
local function scrollListener( event )
 
    local phase = event.phase
    if ( phase == "began" ) then print( "Scroll view was touched" )
    elseif ( phase == "moved" ) then print( "Scroll view was moved" )
    elseif ( phase == "ended" ) then print( "Scroll view was released" )
    end
 
    -- In the event a scroll limit is reached...
    if ( event.limitReached ) then
        if ( event.direction == "up" ) then print( "Reached bottom limit" )
        elseif ( event.direction == "down" ) then print( "Reached top limit" )
        elseif ( event.direction == "left" ) then print( "Reached right limit" )
        elseif ( event.direction == "right" ) then print( "Reached left limit" )
        end
    end
 
    return true
end
 

 local bg = display.newImageRect ("whiteBG.png", 405, 255)
    bg.x = display.contentCenterX
    bg.y = display.contentCenterY
    sceneGroup:insert(bg)

-- Create the widget
local scrollView = widget.newScrollView(
    {
        top = 100,
        left = 10,
        width = 400,
        height = 250,
        backgroundColor = { 69/255, 39/255, 160/255},
        scrollWidth = 600,
        scrollHeight = 300,
        listener = scrollListener
    }
)
 
scrollView.x = display.contentCenterX
scrollView.y = display.contentCenterY





local function closeEditView( event )
 
      if ( event.phase == "began" ) then



    composer.hideOverlay( "fade", 400 )

    parent:updateImage()

    scene:addEventListener( "hide", scene )

    end

end
 

local function  setImage( event)

    if(event.phase == "began") then

     gameData.workingScreen[gameData.indexEdit].image=event.target.imageName

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

composer.showOverlay( "iconFill", options )

    end
return true
end

local function returnMe(event)

 if(event.phase == "began") then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }



composer.showOverlay( "iconFill", options )
end
return true

end    

local function photoOverlay( event )
      if(event.phase == "began") then

            local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }

composer.showOverlay( "myImagePicker", options )

       end
       
  return true      
end



 local startX = 50
 local startY = 50



for i=1, #gameData.defaultImages do

backBoxes[i]= display.newImageRect("selectImageBtn.png",55,55)
scrollView:insert(backBoxes[i])
backBoxes[i].x=startX
backBoxes[i].y=startY
imageBoxes[i]=display.newImageRect("pecs/"..gameData.defaultImages[i]..".png",50,50)
scrollView:insert(imageBoxes[i])
imageBoxes[i].imageName=gameData.defaultImages[i]
imageBoxes[i].x=startX
imageBoxes[i].y=startY
imageBoxes[i]:addEventListener("touch", setImage)
startX=startX+70

   if (i % 5 == 0) then
    startY=startY+80
    startX = 50
    end

end    

-- Create text field

local camPic = display.newImageRect("camera.png", 30*1.252,30)
camPic.x=420
camPic.y=45

camPic:addEventListener("touch", photoOverlay)

local closeCross = display.newImageRect("backBtnPopUp.png", 35,35)
closeCross.x=50
closeCross.y=45

closeCross:addEventListener("touch", returnMe)


sceneGroup:insert (imageGroup)
sceneGroup:insert (scrollView)
sceneGroup:insert (camPic)
sceneGroup:insert (closeCross)



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