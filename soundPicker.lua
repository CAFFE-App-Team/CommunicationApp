local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )


 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local imageBoxes={}
 local checkMarks={}
 local labelBox
 local okBtn

 local startLabelText
 local parent
 local iMayPlay=true
 
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
        backgroundColor = { 69/255, 39/255, 160/255 },
        scrollWidth = 600,
        scrollHeight = 300,
        listener = scrollListener
    }
)
 
scrollView.x = display.contentCenterX
scrollView.y = display.contentCenterY

-- Create a image and insert it into the scroll view
--[[local background = display.newImageRect( "fillBg.png", 500, 1000 )
background.x = scrollView.x
background.y = scrollView.y
scrollView:insert(background)--]]



local function closeEditView( event )
 
      if ( event.phase == "began" ) then

    print ("go")

    composer.hideOverlay( "fade", 400 )

    parent:updateImage()
 

    scene:addEventListener( "hide", scene )

    end

end
 
 local function returnMe(event)

 if(event.phase == "began") then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }
audio.stop()

composer.showOverlay( "iconFill", options )
end
return true

end 

local function  playSound( event)

    local function onCompleteSound (event)
        iMayPlay=true
    end

    if(event.phase == "began") then

        if (iMayPlay) then
            iMayPlay=false

         local soundName = event.target.soundName

          local soundToPlay = audio.loadSound( "voice/"..soundName..".mp3", {channel=2} )
          local playMe = audio.play( soundToPlay ,  { onComplete=onCompleteSound } )
    end

end

    return true
end 

local function  setSound( event)

    if(event.phase == "began") then

     gameData.workingScreen[gameData.indexEdit].audio=event.target.soundName

     --experiment

     gameData.workingScreen[gameData.indexEdit].src="local"



       print ("go "..gameData.workingScreen[gameData.indexEdit].audio)

-- need to set text to bangla version of audio look up from list


    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }
audio.stop()
composer.showOverlay( "iconFill", options )

    end
return true
end

local function recordOverlay( event )
      if(event.phase == "began") then

            local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }
audio.stop()
composer.showOverlay( "mySoundPicker", options )

       end
       
  return true      
end

 local startX = 50
 local startY = 50



for i=1, #gameData.defaultSounds do

imageBoxes[i]=display.newImageRect("playIcon.png",50,50)
scrollView:insert(imageBoxes[i])
imageBoxes[i].soundName=gameData.defaultSounds[i]
imageBoxes[i].x=startX
imageBoxes[i].y=startY
imageBoxes[i]:addEventListener("touch", playSound)

checkMarks[i] = display.newImageRect("select.png",20,20)
scrollView:insert(checkMarks[i])
checkMarks[i].x = imageBoxes[i].x+15
checkMarks[i].y = imageBoxes[i].y+20
checkMarks[i].soundName = gameData.defaultSounds[i]
checkMarks[i]:addEventListener("touch", setSound)




local soundLabel = display.newText(  gameData.defaultSoundsBangla[i], imageBoxes[i].x, imageBoxes[i].y+40, native.systemFont, 16 )  
scrollView:insert(soundLabel)

--print ("my index for bangla sound text is "..i)

startX=startX+70

   if (i % 5 == 0) then
    startY=startY+80
    startX = 50
    end

end    

-- Create text field

local mikePic = display.newImageRect("recordIcon.png", 30,30*1.549)
mikePic.x=420
mikePic.y=65

mikePic:addEventListener("touch", recordOverlay)

local closeCross = display.newImageRect("backBtnPopUp.png", 35,35)
closeCross.x=50
closeCross.y=45

closeCross:addEventListener("touch", returnMe)


sceneGroup:insert (imageGroup)
sceneGroup:insert (scrollView)
sceneGroup:insert(mikePic)
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