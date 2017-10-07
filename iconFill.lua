local composer = require( "composer" )
local gameData = require( "gameData" )
local widget = require( "widget" )
local loadsave = require( "loadsave" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local labelInput
 local backBox
 local labelBox
 local imageBox
 local soundBox
 local soundLabel
 local recordBtn
 local okBtn
 local noObjects

 local startLabelText
 local parent

 local alreadySubmitted=false

 local iMayPlay=true

 local side = -20
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )

    local phase = event.phase


 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 -- ScrollView listener



   




local function SaveToTable()

  loadsave.saveTable (gameData.screenList, "screenList.json" )

end



 startLabelText = gameData.workingScreen[gameData.indexEdit].text
 if (startLabelText=="") then
    startLabelText="text"
 end   

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
        scrollWidth = 600,
        scrollHeight = 800,
        backgroundColor = { 69/255, 39/255, 160/255 },
        horizontalScrollDisabled = true,
        listener = scrollListener
    }
)
 
scrollView.x = display.contentCenterX
scrollView.y = display.contentCenterY



local labelTextName = display.newText(  "এই কার্ডের নাম দিন।", 200, 55, native.systemFont, 14 ) 
scrollView:insert( labelTextName )

--[[local labelTextImage = display.newText(  "Select an image or take a picture", 180, 150, native.systemFont, 14 ) 
scrollView:insert( labelTextImage )

local labelTextSound = display.newText(  "Listen    Select a sound   Record a sound", 190, 230, native.systemFont, 12 ) 
scrollView:insert( labelTextSound )--]]

local defaultField


local function cancelClose(  )
 
  --if ( event.phase == "began" ) then

print ("cancel")

gameData.enterEditMode=false

composer.hideOverlay( "fade", 400 )

parent:resetTopBar()

scene:addEventListener( "hide", scene )

--end

end

local function noSoundImageWarn()

print ("nsw")

    local function closeMe( event )
        
        if ( event.phase == "began" ) then

            noObjects:removeSelf()
            noObjects=nil
            okBtn:removeSelf()
            okBtn=nil

        end  
        return true 
    end

        local function catch( event )
        
        if ( event.phase == "began" ) then

            -- just catch the touch

        end  
        return true 
    end

noObjects = display.newImageRect("needSoundImg.png", 500*1.517, 500)
noObjects.x = display.contentCenterX
noObjects.y = display.contentCenterY
sceneGroup:insert(noObjects)

noObjects:addEventListener("touch", catch)

okBtn = display.newImageRect("okTextBtn.png", 35*2.58,35)
okBtn.name = "ok"
okBtn.x = display.contentCenterX 
okBtn.y = display.contentCenterY + 50
sceneGroup:insert(okBtn)

okBtn:addEventListener("touch", closeMe)

end    

local function closeEditView(  )
 
 -- if ( event.phase == "began" ) then

print ("go")

if (gameData.workingScreen[gameData.indexEdit].image == "non" or gameData.workingScreen[gameData.indexEdit].audio == "") then

noSoundImageWarn()
    else

--loadsave.saveTable (gameData.workingScreen, gameData.saveFile..".json" )
SaveToTable()

gameData.enterEditMode=false

composer.hideOverlay( "fade", 400 )

parent:updateBoxes()

scene:addEventListener( "hide", scene )

--end

end

return true

end
 
local function textListener( event )
 
    if ( event.phase == "began" ) then
        -- User begins editing "defaultField"
        alreadySubmitted=false
 
    elseif ( event.phase == "ended" or  event.phase == "submitted" ) then
        -- Output resulting text from "defaultField"
        print( event.target.text )
        print ("submitted")
        alreadySubmitted=true
        submitValue()
 
    elseif ( event.phase == "editing" ) then
        print( event.newCharacters )
        print( event.oldText )
        print( event.startPosition )
        print( event.text )
    end

    return true
end
 


local function  editSound( )

--if(event.phase == "began") then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }
audio.stop()
composer.showOverlay( "soundPicker", options )

 --   end 

  --  return true
end 




local function  editImage( )

--if(event.phase == "began") then

    local options =
    {
        isModal = true,
        effect = "fade",
        time = 400,

    }
audio.stop()
composer.showOverlay( "imagePicker", options )

   -- end 

   -- return true
end 

local function openInputField( event )


    function submitValue()

                print ("enterValue")

        local enteredText  

        if (defaultField ~= nil) then

        if (defaultField.text==nil) then
        enteredText = ""
        else
        enteredText = defaultField.text
        end    

        else
        enteredText = ""

        end

      gameData.workingScreen[gameData.indexEdit].text=enteredText

        labelBox = display.newRect( scrollView, 220+side, 30, 100, 20 )
        scrollView:insert( labelBox )
        labelInput = display.newText(  defaultField.text, labelBox.x, labelBox.y, native.systemFont, 16 ) 
        labelInput:setFillColor( 0,0,0 )
        scrollView:insert(labelInput)
        labelInput:addEventListener( "touch", openInputField )
        native.setKeyboardFocus( nil )

                if (defaultField ~= nil) then
                    defaultField:removeSelf()
                    defaultField=nil
                    okBtn:removeSelf( )
                    okBtn=nil
                end 

             alreadySubmitted=false

             return true

    end    


     function enterValue( event )

     if(event.phase == "began") then

        submitValue()

    end

    return true

    end    

    -- activate on began (when finger forst touches screen)
     
     if(event.phase == "began") then

labelInput:removeEventListener( "touch", openInputField )

local tempText = labelInput.text

        if (labelInput ~= nil) then
            labelInput:removeSelf()
            labelInput=nil
            labelBox:removeSelf( )
            labelBox=nil
        end 

        defaultField = native.newTextField( 220+side, 30, 100, 20  )
        scrollView:insert(defaultField)
        defaultField.text = tempText

        defaultField:addEventListener( "userInput", textListener )
        --scrollView:insert(defaultField)
        native.setKeyboardFocus( defaultField )

okBtn = display.newImageRect("select.png", 20, 20)
okBtn.x = defaultField.x+70
okBtn.y = defaultField.y
scrollView:insert(okBtn)

        okBtn:addEventListener( "touch", enterValue )

        --experiemnt


     
     end

      return true
end




local function playSound(  )

    local function onCompleteSound (event)
        iMayPlay=true
    end 

     --if(event.phase == "began") then

if (iMayPlay) then
    
iMayPlay=false
        local soundName = gameData.workingScreen[gameData.indexEdit].audio

        local soundToPlay = nil
           soundToPlay = audio.loadSound( "voice/"..soundName..".mp3", {channel=2} )

          if (soundToPlay==nil)then
               soundToPlay = audio.loadSound( "sounds/"..soundName..".wav", system.DocumentsDirectory )
          end  

          local playMe = audio.play( soundToPlay, { onComplete=onCompleteSound } )

  --  end

    --return true
end


end

-- Create text field



 local function submitValueOther(event)

    if(event.phase == "began") then

    if (alreadySubmitted==false) then

                print ("enterValue other submit")

        if (defaultField) then

      local enteredText  

        if (defaultField ~= nil) then

        if (defaultField.text==nil) then
        enteredText = ""
        else
        enteredText = defaultField.text
        end    

        else
        enteredText = ""

        end

      gameData.workingScreen[gameData.indexEdit].text=enteredText

        labelBox = display.newRect( scrollView, 200+side, 30, 100, 20 )
        scrollView:insert( labelBox )
        labelInput = display.newText(  defaultField.text, labelBox.x, labelBox.y, native.systemFont, 16 ) 
        labelInput:setFillColor( 0,0,0 )
        scrollView:insert(labelInput)
        labelInput:addEventListener( "touch", openInputField )
        native.setKeyboardFocus( nil )

                if (defaultField ~= nil) then
                    defaultField:removeSelf()
                    defaultField=nil
                    okBtn:removeSelf( )
                    okBtn=nil
                end 

             
                print ('other sub id '..event.target.id)

                   end

    if (event.target.id=="done") then
        closeEditView()
    end

    if (event.target.id=="image") then
        editImage()
    end

    if (event.target.id=="sound") then
        playSound()
    end

    if (event.target.id=="edit") then
        editSound()
    end

    if (event.target.id=="close") then
        cancelClose()
    end

  end

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




labelBox = display.newRect( scrollView, 220+side, 30, 100, 20 )
scrollView:insert( labelBox )
labelInput = display.newText(  startLabelText, labelBox.x, labelBox.y, native.systemFont, 16 ) 
labelInput:setFillColor( 0,0,0 )
scrollView:insert( labelInput )
labelInput:addEventListener( "touch", openInputField )

backBox= display.newImageRect("selectPhotoBtn.png",60,60)
backBox.x = labelBox.x-40
backBox.y = labelBox.y+80
imageBox = display.newImageRect("pecs/"..gameData.workingScreen[gameData.indexEdit].image..".png",35,35)
if (imageBox==nil)then
imageBox = display.newImageRect(gameData.workingScreen[gameData.indexEdit].image,system.DocumentsDirectory,30,30)
end    
scrollView:insert(backBox)
scrollView:insert (imageBox)
imageBox.x = backBox.x
imageBox.y = labelBox.y+80
imageBox.id="image"
--imageBox:addEventListener( "touch", editImage )
imageBox:addEventListener( "touch", submitValueOther )


local camPic = display.newImageRect("takePhotoBtn.png", 60,60)
camPic.x=imageBox.x + 80
camPic.y=imageBox.y
scrollView:insert(camPic)

camPic:addEventListener("touch", photoOverlay)



soundBox = display.newImageRect("playSoundBtn.png",60,60)
scrollView:insert(soundBox)
soundBox.x = imageBox.x - 45
soundBox.y = imageBox.y + 80
--soundBox:addEventListener("touch", playSound)
soundBox.id="sound"
soundBox:addEventListener( "touch", submitValueOther )

local editBtn = display.newImageRect( "selectSoundBtn.png",60,60)
scrollView:insert(editBtn)
editBtn.x = soundBox.x+80
editBtn.y = soundBox.y

--editBtn:addEventListener( "touch", editSound )
editBtn.id="edit"
editBtn:addEventListener( "touch", submitValueOther )



local audioLabelText

if (gameData.workingScreen[gameData.indexEdit].audio==nil or gameData.workingScreen[gameData.indexEdit].audio=="") then

    else

audioLabelText =""

if(gameData.workingScreen[gameData.indexEdit].audio:match("%W")) then
  --Improper characters detected.
  print ("non alpha")
  audioLabelText = gameData.workingScreen[gameData.indexEdit].audio
else
    print ("alpha")

  local myIndex = table.indexOf( gameData.defaultSounds, gameData.workingScreen[gameData.indexEdit].audio )

    audioLabelText = gameData.defaultSoundsBangla[myIndex]
end

end

if (audioLabelText==nil) then

audioLabelText=""
    end

soundLabel = display.newText(  audioLabelText, soundBox.x, soundBox.y+26, native.systemFont, 11 )  
soundLabel.y = soundLabel.y-48
soundLabel:setFillColor(0,0,0)

--imageBox = display.newImageRect(gameData.homeScreen[gameData.indexEdit].image,system.DocumentsDirectory,60,60)


scrollView:insert(soundLabel)




local mikePic = display.newImageRect("recordSelectionBtn.png", 60,60)
mikePic.x=editBtn.x+80
mikePic.y=soundBox.y
scrollView:insert(mikePic)

mikePic:addEventListener("touch", recordOverlay)

local doneBtn = display.newImageRect("okTextBtn.png", 30*2.58,30)
doneBtn.x = 395
doneBtn.y = 260

--local doneBtn = display.newText(  "DONE", 395, 260, native.systemFont, 16 ) 
doneBtn.id="done"
doneBtn:addEventListener( "touch", submitValueOther )
--doneBtn:addEventListener( "touch", closeEditView )

local closeCross = display.newImageRect("closeBtn.png", 40,40)
closeCross.x=70
closeCross.y=60
closeCross.id="close"

--closeCross:addEventListener("touch", cancelClose)
closeCross:addEventListener( "touch", submitValueOther )


sceneGroup:insert (imageGroup)
sceneGroup:insert (scrollView)
sceneGroup:insert(doneBtn)
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